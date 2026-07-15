---
description: Create Jira tickets from Agent OS tasks with full spec context
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Jira Tickets Creation Rules

## Overview

Convert Agent OS tasks into structured Jira tickets with full spec context for team collaboration.

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

Use the context-fetcher subagent to read and parse spec files for ticket context.

<file_parsing>
  <spec_md>
    - READ spec.md
    - EXTRACT: Overview, User Stories, Spec Scope, Expected Deliverable
    - PURPOSE: Provide context for Jira tickets
  </spec_md>
  <tasks_md>
    - READ tasks.md
    - PARSE: Major tasks (numbered 1, 2, 3...)
    - PARSE: Subtasks (decimal notation 1.1, 1.2, 1.3...)
    - STRUCTURE: Each major task becomes a Jira ticket
  </tasks_md>
  <technical_spec>
    - READ sub-specs/technical-spec.md (if exists)
    - EXTRACT: Technical requirements
    - PURPOSE: Add technical context to tickets
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
    PARSE existing Jira tickets
    IDENTIFY tasks already with tickets
    WARN user about potential duplicates
  ELSE:
    PROCEED (no previous issues recorded)
</registry_check>

<duplicate_detection>
  FOR each major_task from tasks.md:
    CHECK if task already has Jira ticket in registry
    IF duplicate_found:
      PROMPT user: "Task '{task_title}' already has Jira ticket {ticket_key}.
      Continue anyway? (yes/no/skip-duplicates)"

  HANDLE user response:
    - "yes": Create all tickets including duplicates
    - "no": Cancel ticket creation
    - "skip-duplicates": Only create tickets for tasks without existing Jira tickets
</duplicate_detection>

</step>

<step number="4" name="jira_configuration">

### Step 4: Jira Configuration Check

Verify Jira/Atlassian MCP server availability and configuration.

<mcp_verification>
  CHECK Atlassian MCP server availability
  REQUIRED_TOOLS:
    - create_issue
    - list_projects
    - get_project_info
</mcp_verification>

<configuration_prompts>
  ASK user for:
    - Jira project key/name
    - Issue type (Story, Task, Bug, etc.)
    - Priority level (optional)
    - Default assignee (optional)
    - Labels/Components (optional)
    - Execution mode: "Would you like to create tickets immediately or do a dry run first to preview them?
      1. **Dry Run** - Preview tickets and save to files (recommended)
      2. **Create Now** - Create tickets directly in Jira
      Choose 1 or 2:"
</configuration_prompts>

<error_handling>
  IF jira_mcp_not_available:
    ERROR: "Jira/Atlassian MCP server not configured. Please install and configure Atlassian Remote MCP Server or community alternative."
    GUIDANCE: "Recommended: Atlassian's official Remote MCP Server for secure cloud integration"
  IF authentication_failed:
    ERROR: "Jira authentication failed. Please check your Atlassian OAuth/token configuration."
</error_handling>

</step>

<step number="5" name="ticket_preparation">

### Step 5: Ticket Preparation

Prepare Jira ticket content for each major task.

<ticket_template>
  FOR each major_task:
    SUMMARY: "{task_title}"

    DESCRIPTION:
      "h2. Context
      📋 *Spec*: {spec_folder_link}
      🎯 *Feature*: {spec_overview}

      h2. User Story
      {relevant_user_story_from_spec}

      h2. Tasks Checklist
      {formatted_subtasks_as_checkboxes}

      h2. Acceptance Criteria
      {expected_deliverable_from_spec}

      {technical_notes_if_available}

      ----
      _Generated from Agent OS spec: {spec_folder_name}_"

    METADATA:
      - project_key: {configured_project}
      - issue_type: {configured_type}
      - priority: {configured_priority}
      - labels: {configured_labels}
      - assignee: {configured_assignee}
</ticket_template>

<formatting_rules>
  <subtasks_formatting>
    ☐ {subtask_1.1_description}
    ☐ {subtask_1.2_description}
    ☐ {subtask_1.3_description}
  </subtasks_formatting>
  <jira_markup>
    - USE Jira wiki markup formatting
    - h2. for headers
    - ☐ for checkboxes (or create actual sub-tasks)
    - {code} blocks for technical details
  </jira_markup>
  <technical_notes>
    IF technical-spec.md exists:
      ADD "h2. Technical Requirements" section
      INCLUDE relevant technical details in {code} blocks
  </technical_notes>
</formatting_rules>

</step>

<step number="6" name="subtask_strategy">

### Step 6: Subtask Strategy Selection

Determine how to handle subtasks in Jira.

<subtask_options>
  <option_a>
    STRATEGY: Checklist in description
    BENEFIT: Simple, single ticket per major task
    FORMAT: Use checkbox formatting in description
  </option_a>
  <option_b>
    STRATEGY: Jira sub-tasks
    BENEFIT: Individual tracking and assignment
    FORMAT: Create parent ticket + linked sub-tasks
  </option_b>
</subtask_options>

<strategy_selection>
  PROMPT user: "How would you like to handle subtasks?

  1. **Checklist** - Include subtasks as checkboxes in ticket description (simpler)
  2. **Sub-tickets** - Create individual Jira sub-tasks (more detailed tracking)

  Choose 1 or 2:"

  STORE user preference for ticket creation
</strategy_selection>

</step>

<step number="7" name="dry_run_preview">

### Step 7: Dry Run Preview and File Output

Handle both dry run mode and immediate creation mode based on user selection.

<mode_handling>
  IF execution_mode == "dry_run":
    PROCEED to dry run file creation
  IF execution_mode == "create_now":
    PROCEED to ticket creation (Step 8)
</mode_handling>

<dry_run_file_creation>
  CREATE dry run output directory if not exists:
    DIRECTORY: .agent-os/specs/{spec_folder_name}/dry-runs/

  GENERATE timestamp:
    FORMAT: YYYY-MM-DD-HHMMSS
    EXAMPLE: 2024-01-15-143022

  CREATE dry run file:
    FILENAME: jira-tickets-preview-{timestamp}.md
    FULL_PATH: .agent-os/specs/{spec_folder_name}/dry-runs/jira-tickets-preview-{timestamp}.md
</dry_run_file_creation>

<dry_run_content_format>
  FILE CONTENT:
    "# Jira Tickets Preview
    Generated: {current_date_time}
    Spec: {spec_folder_name}
    Project: {project_key}

    ## Summary
    - Total tickets to create: {ticket_count}
    - Issue type: {issue_type}
    - Priority: {priority_level}
    - Subtask strategy: {checklist_or_subtasks}
    - Labels: {labels_list}
    - Default assignee: {assignee_if_set}

    ---

    ## Ticket Details

    {for_each_prepared_ticket}
    ### Ticket {number}: {task_title}

    **Jira Fields:**
    - Summary: {ticket_summary}
    - Project: {project_key}
    - Issue Type: {issue_type}
    - Priority: {priority_level}
    - Labels: {labels_list}
    - Assignee: {assignee_if_set}

    **Description:**
    ```
    {full_ticket_description}
    ```

    **Subtasks:**
    {if_subtask_strategy_is_sub_tickets}
    - {subtask_1_title}
    - {subtask_2_title}
    - {subtask_N_title}
    {else_if_subtask_strategy_is_checklist}
    (Included as checkboxes in description above)

    ---
    {end_for_each_ticket}

    ## Next Steps
    To proceed with creating these tickets in Jira:
    1. Review the ticket details above
    2. Run the create-jira-issues command again
    3. When prompted for execution mode, choose 'Create Now'
    4. Or use the 'proceed' option if available in the current session
    "
</dry_run_content_format>

<console_preview>
  DISPLAY brief summary to console:
    "📋 Dry Run Complete!

    Prepared {ticket_count} Jira tickets for project {project_key}
    Preview saved to: .agent-os/specs/{spec_folder_name}/dry-runs/jira-tickets-preview-{timestamp}.md

    📖 Review the detailed preview file to see full ticket content.
    "
</console_preview>

<user_confirmation>
  PROMPT: "Would you like to proceed with creating these tickets in Jira now?

  Options:
  - 'yes' - Create all {ticket_count} tickets immediately
  - 'no' - Exit and review the dry run file first
  - 'show' - Display ticket summaries in console

  Choose an option:"
</user_confirmation>

<confirmation_flow>
  IF user_response == "yes":
    PROCEED to ticket creation (Step 8)
  IF user_response == "show":
    DISPLAY brief ticket summaries in console, then re-prompt
  IF user_response == "no":
    ABORT with success message and file location
  ELSE:
    RE-PROMPT for valid response
</confirmation_flow>

</step>

<step number="8" name="ticket_creation">

### Step 8: Jira Ticket Creation

Create Jira tickets using MCP server tools. This step is only executed if:
- User chose "Create Now" in Step 4, OR
- User chose "yes" to proceed after dry run preview in Step 7

<creation_loop>
  FOR each prepared_ticket:
    CALL jira_mcp.create_issue with:
      - project: {configured_project}
      - summary: {ticket_summary}
      - description: {formatted_description}
      - issuetype: {configured_issue_type}
      - priority: {configured_priority}
      - labels: {configured_labels}
      - assignee: {configured_assignee}

    IF subtask_strategy == "sub-tickets":
      FOR each subtask:
        CALL jira_mcp.create_issue with:
          - project: {configured_project}
          - summary: {subtask_title}
          - description: {subtask_details}
          - issuetype: "Sub-task"
          - parent: {parent_ticket_key}

    TRACK:
      - ticket_url
      - ticket_key
      - creation_status
      - subtask_keys (if applicable)

    LOG success/failure for each ticket
</creation_loop>

<error_handling>
  IF ticket_creation_fails:
    LOG error details
    CONTINUE with remaining tickets
    REPORT failed tickets at end

  IF rate_limit_exceeded:
    PAUSE and retry with exponential backoff
    INFORM user of delay

  IF subtask_creation_fails:
    LOG subtask errors separately
    CONTINUE with parent ticket creation
</error_handling>

</step>

<step number="9" name="issue_registry_update">

### Step 9: Issue Registry Update

Update the issue registry with created Jira tickets.

<registry_update>
  CREATE or UPDATE file: .agent-os/specs/{spec_folder_name}/issues.md

  IF issues.md does not exist:
    CREATE new file with header:
      "# Created Issues\n\n## GitHub Issues\n\n## Jira Tickets\n\n## Creation History\n"

  FOR each successfully created ticket:
    ADD entry under "## Jira Tickets" section:
      "- [x] **{task_title}**
        - Ticket: {ticket_key} - {ticket_url}
        - Created: {current_date}
        - Status: {ticket_status}
        - Assignee: {assignee_if_set}"

  IF subtasks were created:
    ADD sub-entries for each subtask:
      "  - Sub-task: {subtask_key} - {subtask_url}"

  ADD entry under "## Creation History" section:
    "- {current_date}: Created {success_count} Jira tickets for project {project_key}"
</registry_update>

<file_formatting>
  MAINTAIN consistent formatting:
    - Use checkboxes [x] for completed task tracking
    - Include all relevant metadata (ticket key, URL, date, status, assignee)
    - Keep chronological order in Creation History
    - Preserve existing GitHub issues section if present
    - Indent sub-tasks appropriately
</file_formatting>

</step>

<step number="10" name="results_summary">

### Step 10: Results Summary

Provide comprehensive summary of created tickets.

<summary_report>
  IF execution_mode == "dry_run" AND user_chose_no_to_proceed:
    DISPLAY:
      "📋 Dry Run Complete - No Tickets Created

      Project: {project_key}
      Spec: {spec_folder_name}
      Preview file: .agent-os/specs/{spec_folder_name}/dry-runs/jira-tickets-preview-{timestamp}.md

      Prepared {ticket_count} tickets for future creation.

      Next Steps:
      1. Review the detailed preview file
      2. Compare with previous dry runs if needed
      3. Run create-jira-issues again and choose 'Create Now'
      4. Or modify tasks.md and re-run dry run as needed"

  ELSE (tickets were actually created):
    DISPLAY:
      "✅ Jira Tickets Created Successfully

      Project: {project_key}
      Spec: {spec_folder_name}
      {if_dry_run_was_used}
      Dry run preview: .agent-os/specs/{spec_folder_name}/dry-runs/jira-tickets-preview-{timestamp}.md

      Created Tickets:
      {for_each_successful_ticket}
      - {ticket_key}: {ticket_summary}
        URL: {ticket_url}
        {if_subtasks_created}
        Sub-tasks: {subtask_keys_list}

      {if_any_failures}
      ❌ Failed Tickets:
      - {failed_ticket_details}

      📋 Total: {success_count}/{total_count} tickets created
      🔗 View all tickets: {project_board_url}
      📝 Issue registry updated: .agent-os/specs/{spec_folder_name}/issues.md

      Next Steps:
      - Review and prioritize tickets
      - Assign tickets to team members
      - Update sprint planning
      - Link to epics if applicable"
</summary_report>

<follow_up_actions>
  SUGGEST:
    - Sprint assignment if using Scrum
    - Epic linkage for larger features
    - Story point estimation
    - Team capacity planning
    - Integration with development workflows
</follow_up_actions>

</step>

</process_flow>

<post_flight_check>
  EXECUTE: @.agent-os/instructions/meta/post-flight.md
</post_flight_check>