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

<step number="3" name="github_configuration">

### Step 3: GitHub Configuration Check

Verify GitHub MCP server availability and configuration.

<mcp_verification>
  CHECK GitHub MCP server availability
  REQUIRED_TOOLS:
    - create_issue
    - list_repositories
    - get_repository_info
</mcp_verification>

<configuration_prompts>
  ASK user for:
    - Repository name/URL
    - Project board assignment (optional)
    - Default labels (optional)
    - Default assignees (optional)
    - Issue creation mode (dry-run vs actual)
</configuration_prompts>

<error_handling>
  IF github_mcp_not_available:
    ERROR: "GitHub MCP server not configured. Please install and configure a GitHub MCP server."
    GUIDANCE: "Available options: Microsoft GitHub MCP server or community alternatives"
  IF authentication_failed:
    ERROR: "GitHub authentication failed. Please check your GitHub token/OAuth configuration."
</error_handling>

</step>

<step number="4" name="issue_preparation">

### Step 4: Issue Preparation

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

<step number="5" name="dry_run_preview">

### Step 5: Dry Run Preview (Optional)

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

<step number="6" name="issue_creation">

### Step 6: GitHub Issue Creation

Create GitHub issues using MCP server tools.

<creation_loop>
  FOR each prepared_issue:
    CALL github_mcp.create_issue with:
      - repository: {configured_repo}
      - title: {issue_title}
      - body: {formatted_description}
      - labels: {configured_labels}
      - assignees: {configured_assignees}

    TRACK:
      - issue_url
      - issue_number
      - creation_status

    LOG success/failure for each issue
</creation_loop>

<error_handling>
  IF issue_creation_fails:
    LOG error details
    CONTINUE with remaining issues
    REPORT failed issues at end

  IF rate_limit_exceeded:
    PAUSE and retry with exponential backoff
    INFORM user of delay
</error_handling>

</step>

<step number="7" name="results_summary">

### Step 7: Results Summary

Provide comprehensive summary of created issues.

<summary_report>
  DISPLAY:
    "✅ GitHub Issues Created Successfully

    Repository: {repository_name}
    Spec: {spec_folder_name}

    Created Issues:
    {for_each_successful_issue}
    - #{issue_number}: {issue_title}
      URL: {issue_url}

    {if_any_failures}
    ❌ Failed Issues:
    - {failed_issue_details}

    📋 Total: {success_count}/{total_count} issues created
    🔗 View all issues: {repository_issues_url}

    Next Steps:
    - Assign issues to team members
    - Add to project boards if not automated
    - Update issue priorities as needed"
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