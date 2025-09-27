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

<step number="3" name="jira_configuration">

### Step 3: Jira Configuration Check

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
    - Ticket creation mode (dry-run vs actual)
</configuration_prompts>

<error_handling>
  IF jira_mcp_not_available:
    ERROR: "Jira/Atlassian MCP server not configured. Please install and configure Atlassian Remote MCP Server or community alternative."
    GUIDANCE: "Recommended: Atlassian's official Remote MCP Server for secure cloud integration"
  IF authentication_failed:
    ERROR: "Jira authentication failed. Please check your Atlassian OAuth/token configuration."
</error_handling>

</step>

<step number="4" name="ticket_preparation">

### Step 4: Ticket Preparation

Prepare Jira ticket content for each major task.

<ticket_template>
  FOR each major_task:
    SUMMARY: "[Task {task_number}] {task_title}"

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

<step number="5" name="subtask_strategy">

### Step 5: Subtask Strategy Selection

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

<step number="6" name="dry_run_preview">

### Step 6: Dry Run Preview (Optional)

If dry-run mode enabled, show preview of tickets to be created.

<preview_format>
  DISPLAY for each prepared ticket:
    "**Ticket {number}**: {summary}
    Project: {project_key}
    Type: {issue_type}
    Priority: {priority_level}
    Labels: {labels_list}
    Assignee: {assignee_if_set}
    Subtask Strategy: {checklist_or_subtasks}

    Preview of description (first 200 chars)...
    "
</preview_format>

<user_confirmation>
  PROMPT: "Ready to create {ticket_count} Jira tickets in project {project_key}?

  Type 'yes' to proceed with creation, 'preview' to see full ticket content, or 'cancel' to abort."
</user_confirmation>

<confirmation_flow>
  IF user_response == "yes":
    PROCEED to ticket creation
  IF user_response == "preview":
    SHOW full ticket content, then re-prompt
  IF user_response == "cancel":
    ABORT with success message
  ELSE:
    RE-PROMPT for valid response
</confirmation_flow>

</step>

<step number="7" name="ticket_creation">

### Step 7: Jira Ticket Creation

Create Jira tickets using MCP server tools.

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

<step number="8" name="results_summary">

### Step 8: Results Summary

Provide comprehensive summary of created tickets.

<summary_report>
  DISPLAY:
    "✅ Jira Tickets Created Successfully

    Project: {project_key}
    Spec: {spec_folder_name}

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