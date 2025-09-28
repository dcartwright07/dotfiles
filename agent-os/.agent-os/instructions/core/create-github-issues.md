---
description: Create GitHub issues from Agent OS tasks with full spec context
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# GitHub Issues Creation Rules

## Overview

Convert Agent OS tasks into structured GitHub issues with full spec context for team collaboration.

<pre_flight_check>
  EXECUTE: @.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" subagent="context-fetcher" name="spec_detection">

### Step 1: Spec Detection and Validation

Use the context-fetcher subagent to locate the current spec folder and validate required files exist.

<spec_detection>
  <auto_detection>
    - SEARCH for most recent spec folder in @.agent-os/specs/
    - PATTERN: YYYY-MM-DD-spec-name format
    - VERIFY tasks.md exists in spec folder
  </auto_detection>
  <manual_override>
    - ACCEPT user-specified spec folder path
    - VALIDATE folder structure and required files
  </manual_override>
</spec_detection>

<required_files>
  - spec.md (main specification)
  - tasks.md (generated tasks)
  - spec-lite.md (summary context)
</required_files>

<validation_checks>
  IF spec_folder_not_found:
    ERROR: "No spec folder detected. Please run /create-spec first."
  IF tasks_md_not_found:
    ERROR: "No tasks.md found. Please run /create-tasks first."
  ELSE:
    PROCEED to context gathering
</validation_checks>

</step>

<step number="2" subagent="context-fetcher" name="context_gathering">

### Step 2: Context Gathering

Use the context-fetcher subagent to read and parse spec files for issue context.

<file_parsing>
  <spec_md>
    - READ spec.md
    - EXTRACT: Overview, User Stories, Spec Scope, Expected Deliverable
    - PURPOSE: Provide context for GitHub issues
  </spec_md>
  <tasks_md>
    - READ tasks.md
    - PARSE: Major tasks (numbered 1, 2, 3...)
    - PARSE: Subtasks (decimal notation 1.1, 1.2, 1.3...)
    - STRUCTURE: Each major task becomes a GitHub issue
  </tasks_md>
  <technical_spec>
    - READ sub-specs/technical-spec.md (if exists)
    - EXTRACT: Technical requirements
    - PURPOSE: Add technical context to issues
  </technical_spec>
</file_parsing>

<data_structure>
  FOR each major_task in tasks.md:
    STORE:
      - task_number
      - task_title
      - associated_subtasks[]
      - relevant_user_story (from spec.md)
      - technical_requirements (if applicable)
</data_structure>

</step>

<step number="3" name="issue_registry_check">

### Step 3: Issue Registry Check

Check for existing issues in the spec folder to avoid duplicates.

<registry_check>
  CHECK if issues.md exists in spec folder:
    FILE: .agent-os/specs/{spec_folder_name}/issues.md

  IF issues.md exists:
    READ file content
    PARSE existing GitHub issues
    IDENTIFY tasks already with issues
    WARN user about potential duplicates
  ELSE:
    PROCEED (no previous issues recorded)
</registry_check>

<duplicate_detection>
  FOR each major_task from tasks.md:
    CHECK if task already has GitHub issue in registry
    IF duplicate_found:
      PROMPT user: "Task '{task_title}' already has GitHub issue #{issue_number}.
      Continue anyway? (yes/no/skip-duplicates)"

  HANDLE user response:
    - "yes": Create all issues including duplicates
    - "no": Cancel issue creation
    - "skip-duplicates": Only create issues for tasks without existing GitHub issues
</duplicate_detection>

</step>

<step number="4" name="git_config_detection">

### Step 4: Git Configuration Detection

Automatically detect GitHub repository information from git configuration.

<git_detection>
  EXECUTE the following git commands to detect repository information:
    - git remote get-url origin (get repository URL)
    - git config user.name (get default assignee name)
    - git config user.email (get default assignee email)
    - git branch --show-current (get current branch)
    - git config --get remote.origin.url (alternative URL detection)
</git_detection>

<url_parsing>
  PARSE the git remote URL to extract:
    - repository_owner (from URL path)
    - repository_name (from URL path)
    - hosting_platform (github.com, github.enterprise.com, etc.)

  SUPPORTED_URL_FORMATS:
    - https://github.com/owner/repo.git
    - git@github.com:owner/repo.git
    - https://github.enterprise.com/owner/repo.git
    - git@github.enterprise.com:owner/repo.git
</url_parsing>

<auto_configuration>
  IF git_remote_detected AND platform_is_github:
    STORE detected values:
      - repository_url: {parsed_from_git_remote}
      - repository_owner: {extracted_owner}
      - repository_name: {extracted_repo_name}
      - default_assignee: {git_user_name} (if available)
      - hosting_platform: {detected_platform}

    LOG: "Auto-detected GitHub repository: {owner}/{repo}"
  ELSE:
    LOG: "No GitHub repository detected in git remotes"
    SET auto_detected: false
</auto_configuration>

<fallback_handling>
  IF auto_detection_failed OR not_github_repository:
    PROCEED to manual configuration prompts
  ELSE:
    USE detected values as defaults for configuration prompts
</fallback_handling>

</step>

<step number="5" name="github_cli_setup">

### Step 5: GitHub CLI Setup and Configuration

Use GitHub CLI (`gh`) for reliable issue creation and project management.

<gh_cli_verification>
  CHECK GitHub CLI availability:
    EXECUTE: gh --version

  IF gh_not_available:
    ERROR: "GitHub CLI (gh) not found. Please install it first."
    GUIDANCE: "Install with: brew install gh (macOS) or visit https://cli.github.com"
    ABORT process

  CHECK authentication status:
    EXECUTE: gh auth status

  IF not_authenticated:
    PROMPT: "GitHub CLI not authenticated. Run 'gh auth login' to authenticate."
    ABORT process
</gh_cli_verification>

<repository_detection>
  IF auto_detected == true:
    VERIFY repository access:
      EXECUTE: gh repo view {repository_owner}/{repository_name}

    IF repo_accessible:
      LOG: "✅ Repository access confirmed: {repository_owner}/{repository_name}"
      SET repository: "{repository_owner}/{repository_name}"
    ELSE:
      LOG: "❌ Cannot access auto-detected repository"
      PROCEED to manual repository selection

  ELSE:
    PROMPT user for repository:
      "Please specify the GitHub repository:"
      OPTIONS:
        1. Current repository (if in git repo)
        2. Specify owner/repo format
        3. Browse available repositories

    VALIDATE with: gh repo view {user_input}
</repository_detection>

<milestone_configuration>
  ASK user for milestone setup:
    "Create a milestone for this spec? This will group all issues together.

    Milestone options:
    1. Auto-generate: '{spec_folder_name}' (recommended)
    2. Custom milestone name
    3. Use existing milestone
    4. Skip milestone creation"

  HANDLE user choice:
    IF option_1 OR option_2:
      CREATE milestone: gh api repos/{repository}/milestones -f title="{milestone_name}" -f description="Issues for spec: {spec_folder_name}"
      STORE milestone_number for issue assignment

    IF option_3:
      LIST existing milestones: gh api repos/{repository}/milestones --jq '.[].title'
      LET user select from list

    IF option_4:
      SET milestone_number: null
</milestone_configuration>

<project_integration>
  DETECT active projects:
    EXECUTE: gh project list --owner {repository_owner}

  IF projects_found:
    ASK user: "Add issues to a GitHub project?

    Available projects:
    {list_projects_with_numbers}

    Options:
    1. Select project from list
    2. Skip project assignment"

    IF project_selected:
      STORE project_number for issue assignment

      ASK for issue classification:
        "Default issue type for this spec:
        1. Feature (new functionality)
        2. Task (implementation work)
        3. Ask per issue (classify individually)"

      STORE default_issue_type preference

  ELSE:
    LOG: "No GitHub projects found, skipping project assignment"
    SET project_number: null
</project_integration>

<label_configuration>
  GET existing repository labels:
    EXECUTE: gh api repos/{repository}/labels --jq '.[].name'

  SUGGEST relevant labels:
    "Suggested labels for this spec (based on existing repo labels):
    {filter_labels_for_spec_type}

    Additional labels to add to all issues? (comma-separated)"

  STORE selected_labels for issue creation
</label_configuration>

</step>

<step number="6" name="issue_preparation">

### Step 6: Issue Preparation

Prepare GitHub issue content for each major task.

<issue_template>
  FOR each major_task:
TITLE: "{task_title}"

    DESCRIPTION:
      "## Context
      📋 **Spec**: {spec_folder_link}
      🎯 **Feature**: {spec_overview}

      ## User Story
      {relevant_user_story_from_spec}

      ## Tasks Checklist
      {formatted_subtasks_as_checkboxes}

      ## Acceptance Criteria
      {expected_deliverable_from_spec}

      {technical_notes_if_available}

      ---
      *Generated from Agent OS spec: {spec_folder_name}*"
</issue_template>

<formatting_rules>
  <subtasks_formatting>
    - [ ] {subtask_1.1_description}
    - [ ] {subtask_1.2_description}
    - [ ] {subtask_1.3_description}
  </subtasks_formatting>
  <technical_notes>
    IF technical-spec.md exists:
      ADD "## Technical Requirements" section
      INCLUDE relevant technical details
  </technical_notes>
</formatting_rules>

</step>

<step number="6" name="dry_run_preview">

### Step 6: Dry Run Preview (Optional)

If dry-run mode enabled, show preview of issues to be created.

<preview_format>
  DISPLAY for each prepared issue:
    "**Issue {number}**: {title}
    Repository: {repo_name}
    Labels: {labels_list}
    Assignee: {assignee_if_set}

    Preview of description (first 200 chars)...
    "
</preview_format>

<user_confirmation>
  PROMPT: "Ready to create {issue_count} GitHub issues in {repository_name}?

  Type 'yes' to proceed with creation, 'preview' to see full issue content, or 'cancel' to abort."
</user_confirmation>

<confirmation_flow>
  IF user_response == "yes":
    PROCEED to issue creation
  IF user_response == "preview":
    SHOW full issue content, then re-prompt
  IF user_response == "cancel":
    ABORT with success message
  ELSE:
    RE-PROMPT for valid response
</confirmation_flow>

</step>

<step number="8" name="github_issue_creation">

### Step 8: GitHub Issue Creation with gh CLI

Create GitHub issues with full project management integration.

<creation_loop>
  FOR each prepared_issue:
    DETERMINE issue_type:
      IF default_issue_type == "ask_per_issue":
        ASK user: "Issue type for '{issue_title}'?
        1. Feature (new functionality)
        2. Task (implementation work)"
      ELSE:
        USE default_issue_type

    BUILD gh_command:
      BASE: gh issue create --repo {repository}
      ADD: --title "{issue_title}"
      ADD: --body "{formatted_description}"

      IF selected_labels:
        ADD: --label "{comma_separated_labels}"

      IF milestone_number:
        ADD: --milestone {milestone_number}

      IF assignees_configured:
        ADD: --assignee "{assignee_list}"

    EXECUTE issue creation:
      COMMAND: {built_gh_command}
      CAPTURE: issue_url and issue_number from output

    IF project_number:
      ADD issue to project:
        EXECUTE: gh project item-add {project_number} --url {issue_url}

        SET project item type:
          IF issue_type == "feature":
            EXECUTE: gh project item-edit --id {item_id} --field-name "Type" --text "Feature"
          ELSE:
            EXECUTE: gh project item-edit --id {item_id} --field-name "Type" --text "Task"

        SET project status to backlog:
          EXECUTE: gh project item-edit --id {item_id} --field-name "Status" --text "Backlog"

    TRACK creation results:
      - issue_url
      - issue_number
      - milestone_assigned
      - project_assigned
      - issue_type
      - creation_status

    LOG: "✅ Created issue #{issue_number}: {issue_title}"
</creation_loop>

<error_handling>
  IF gh_issue_creation_fails:
    LOG: "❌ Failed to create issue: {issue_title}"
    LOG: "Error: {error_details}"
    CONTINUE with remaining issues
    TRACK failed_issues for final report

  IF project_assignment_fails:
    LOG: "⚠️  Issue created but project assignment failed for #{issue_number}"
    CONTINUE with next issue

  IF milestone_assignment_fails:
    LOG: "⚠️  Issue created but milestone assignment failed for #{issue_number}"
    CONTINUE with next issue

  IF rate_limit_detected:
    LOG: "⏱️  Rate limit detected, waiting 60 seconds..."
    PAUSE 60 seconds
    RETRY current issue
</error_handling>

</step>

<step number="9" name="issue_registry_update">

### Step 9: Issue Registry Update

Update the issue registry with created GitHub issues.

<registry_update>
  CREATE or UPDATE file: .agent-os/specs/{spec_folder_name}/issues.md

  IF issues.md does not exist:
    CREATE new file with header:
      "# Created Issues\n\n## GitHub Issues\n\n## Jira Tickets\n\n## Creation History\n"

  FOR each successfully created issue:
    ADD entry under "## GitHub Issues" section:
      "- [x] **{task_title}**
        - Issue: #{issue_number} - {issue_url}
        - Created: {current_date}
        - Type: {issue_type}
        - Status: Open
        - Milestone: {milestone_name} (if assigned)
        - Project: {project_name} - Backlog (if assigned)
        - Assignee: {assignee_if_set}"

  IF milestone_created:
    ADD milestone info under "## GitHub Issues" section:
      "
      **Milestone Created:** {milestone_name}
      - URL: {milestone_url}
      - Issues: {milestone_issue_count}
      "

  ADD entry under "## Creation History" section:
    "- {current_date}: Created {success_count} GitHub issues for {repository_name}
      - Milestone: {milestone_name} (if created)
      - Project: {project_name} (if assigned)
      - Types: {feature_count} Features, {task_count} Tasks"
</registry_update>

<file_formatting>
  MAINTAIN consistent formatting:
    - Use checkboxes [x] for completed task tracking
    - Include all relevant metadata (issue number, URL, date, status, assignee)
    - Keep chronological order in Creation History
    - Preserve existing Jira tickets section if present
</file_formatting>

</step>

<step number="10" name="results_summary">

### Step 10: Results Summary

Provide comprehensive summary of created issues.

<summary_report>
  DISPLAY:
    "✅ GitHub Issues Created Successfully

    📊 **Summary:**
    Repository: {repository_name}
    Spec: {spec_folder_name}
    Milestone: {milestone_name} (if created)
    Project: {project_name} (if assigned)

    📝 **Created Issues:**
    {for_each_successful_issue}
    - #{issue_number}: {issue_title}
      URL: {issue_url}
      Type: {issue_type}
      Milestone: {milestone_name}
      Project Status: Backlog

    {if_milestone_created}
    🎯 **Milestone Created:**
    - Name: {milestone_name}
    - URL: {milestone_url}
    - Issues assigned: {milestone_issue_count}

    {if_project_assigned}
    📋 **Project Integration:**
    - Project: {project_name}
    - Issues added to Backlog
    - Types set: {feature_count} Features, {task_count} Tasks

    {if_any_failures}
    ❌ **Failed Operations:**
    - {failed_issue_details}
    - {failed_project_assignments}
    - {failed_milestone_assignments}

    📊 **Results:**
    📋 Total: {success_count}/{total_count} issues created
    🔗 View all issues: {repository_issues_url}?milestone={milestone_number}
    📝 Issue registry updated: .agent-os/specs/{spec_folder_name}/issues.md

    🎯 **Quick Links:**
    - Repository: {repository_url}
    - Milestone: {milestone_url} (if created)
    - Project: {project_url} (if assigned)
    - Issues list: {repository_url}/issues?milestone={milestone_number}

    ✨ **Next Steps:**
    - Review issues in project backlog
    - Prioritize and move issues to sprint
    - Assign team members as needed
    - Update issue estimates if using story points"
</summary_report>

<follow_up_actions>
  SUGGEST:
    - Project board assignment if not configured
    - Issue prioritization
    - Team member assignment
    - Integration with CI/CD workflows
</follow_up_actions>

</step>

</process_flow>

<post_flight_check>
  EXECUTE: @.agent-os/instructions/meta/post-flight.md
</post_flight_check>