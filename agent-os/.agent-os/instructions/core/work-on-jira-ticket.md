---
description: Execute a Jira ticket using Agent OS TDD workflow with progress tracking
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Jira Ticket Execution Rules

## Overview

Execute a Jira ticket following the same proven TDD workflow as execute-task.md with automatic progress tracking and team communication via Atlassian MCP server.

<pre_flight_check>
  EXECUTE: @.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="jira_setup_validation">

### Step 1: Jira MCP Server and Project Validation

Verify Atlassian MCP server availability and project access before proceeding.

<mcp_validation>
  <server_check>
    CHECK: Atlassian MCP server availability in active MCP connections
    VERIFY: Authentication and project access permissions
    VALIDATE: Required MCP tools are available (get_issues, add_comment, update_issue)
  </server_check>
  <project_detection>
    EXTRACT: Default Jira project from MCP configuration
    VERIFY: User has ticket read/write permissions
    CONFIRM: Project workflow and available transitions
  </project_detection>
</mcp_validation>

<error_handling>
  IF atlassian_mcp_not_available:
    ERROR: "Atlassian MCP server not configured. Please install and configure Atlassian MCP server for Jira integration."
    GUIDANCE: "Setup instructions: Configure Atlassian Remote MCP Server or community alternative for secure cloud integration."
  IF not_authenticated:
    ERROR: "Jira authentication failed. Please check your Atlassian OAuth/token configuration in MCP server."
  IF no_project_access:
    ERROR: "No Jira project access detected. Verify project permissions in Atlassian MCP configuration."
  IF insufficient_permissions:
    ERROR: "Insufficient Jira permissions. Need read/write access to tickets and ability to add comments."
</error_handling>

<instructions>
  ACTION: Validate Atlassian MCP server and Jira project access
  VERIFY: Authentication and permissions are working
  EXTRACT: Project information for ticket operations
  CONTINUE: Only if all validation checks pass
</instructions>

</step>

<step number="2" name="ticket_discovery_selection">

### Step 2: Ticket Discovery and Selection

Fetch available Jira tickets via MCP server and present interactive selection interface.

<ticket_fetching>
  <fetch_active_tickets>
    MCP_CALL: get_issues with filters:
      - status: "To Do", "In Progress", "Ready for Development"
      - assignee: current_user OR unassigned
      - project: configured_project
    PARSE: Ticket response into structured list
    FILTER: Remove tickets already marked complete in registry
  </fetch_active_tickets>
  <registry_context>
    CHECK: Existing @.agent-os/specs/*/issues.md files for Jira tickets
    EXTRACT: Previously worked tickets and their status
    ENRICH: Ticket list with registry context and completion status
  </registry_context>
</ticket_fetching>

<selection_interface>
  <display_format>
    FOR each available ticket:
      SHOW: "{key}: {summary}"
      SHOW: "  Type: {issuetype} | Priority: {priority}"
      SHOW: "  Status: {status} | Assignee: {assignee}"
      SHOW: "  Registry Status: {registry_status or 'Available'}"
      SHOW: "  Created: {created}"
  </display_format>
  <user_interaction>
    PROMPT: "Which Jira ticket would you like to work on?"
    ACCEPT: Ticket key selection from user (e.g., PROJ-123)
    VALIDATE: Selected ticket exists and is accessible
  </user_interaction>
</selection_interface>

<instructions>
  ACTION: Fetch and display available Jira tickets via MCP
  PRESENT: Clear selection interface with ticket details
  AWAIT: User selection of specific ticket to work on
  VALIDATE: Selected ticket is accessible and appropriate
</instructions>

</step>

<step number="3" name="ticket_analysis_preparation">

### Step 3: Ticket Analysis and Task Preparation

Fetch full ticket details via MCP and convert to Agent OS task format for execution.

<ticket_details_fetch>
  <full_ticket_data>
    MCP_CALL: get_issue with ticket_key to fetch complete details:
      - summary, description, status, priority, assignee
      - comments, attachments, sub-tasks
      - custom fields, labels, components
      - workflow transitions available
    PARSE: Jira markup formatting in description and comments
  </full_ticket_data>
  <content_analysis>
    ANALYZE: Ticket summary for main objective
    EXTRACT: Acceptance criteria from description
    IDENTIFY: Technical requirements from custom fields
    DETECT: Linked tickets or dependencies
    REVIEW: Sub-tasks if present
  </content_analysis>
</ticket_details_fetch>

<task_conversion>
  <main_task_creation>
    TITLE: Use Jira ticket summary as primary task
    DESCRIPTION: Convert ticket description from Jira markup to Agent OS format
    REQUIREMENTS: Extract acceptance criteria as sub-tasks
  </main_task_creation>
  <sub_task_generation>
    IF ticket has sub-tasks:
      CONVERT: Each sub-task to Agent OS sub-task format
    ELSE:
      INFER: Logical sub-tasks from ticket description:
        - "Write tests for {main_feature}"
        - "Implement {specific_functionality}"
        - "Verify all tests pass"
  </sub_task_generation>
</task_conversion>

<progress_initialization>
  <status_transition>
    IF ticket_status == "To Do":
      MCP_CALL: transition_issue to "In Progress"
      LOG: Work started in Jira work log
  </status_transition>
  <initial_comment>
    MCP_CALL: add_comment with content:
      "🚀 *Started working on this ticket*

      Following Agent OS TDD workflow:
      # ✅ Ticket analysis complete
      # ⏳ Writing comprehensive tests
      # ⏳ Implementing functionality
      # ⏳ Verifying all tests pass

      Will provide updates as work progresses."
    PURPOSE: Notify team that work has begun
  </initial_comment>
</progress_initialization>

<instructions>
  ACTION: Fetch complete ticket details via MCP and analyze requirements
  CONVERT: Jira ticket content to Agent OS task format
  TRANSITION: Ticket to "In Progress" if needed
  NOTIFY: Team via Jira comment that work has started
  PREPARE: Task structure for TDD workflow execution
</instructions>

</step>

<step number="4" subagent="context-fetcher" name="spec_context_review">

### Step 4: Spec Context Review

Use context-fetcher subagent to gather relevant spec context for the Jira ticket requirements.

<spec_detection>
  <auto_detection>
    SEARCH: Most recent spec folder in @.agent-os/specs/
    VERIFY: Spec folder contains relevant context for ticket
    FALLBACK: Use current working directory context if no spec
  </auto_detection>
  <context_gathering>
    IF spec_folder_exists:
      REQUEST: context-fetcher to extract relevant sections from:
        - technical-spec.md related to ticket requirements
        - best-practices.md for implementation approach
        - code-style.md for formatting guidelines
    ELSE:
      GATHER: Codebase context relevant to ticket area
  </context_gathering>
</spec_detection>

<instructions>
  ACTION: Use context-fetcher subagent
  REQUEST: "Find spec context relevant to Jira ticket: {ticket_summary}
           Focus on:
           - Technical implementation approach
           - Best practices for this feature type
           - Code style requirements
           - Testing strategies"
  PROCESS: Returned context for implementation guidance
  APPLY: Relevant patterns and requirements to task execution
</instructions>

</step>

<step number="5" name="tdd_workflow_execution">

### Step 5: Execute TDD Workflow with Jira Updates

Execute the Jira ticket using the exact same workflow as execute-task.md steps 5-6 with Jira progress tracking.

<tdd_execution>
  <test_writing_phase>
    EXECUTE: Test writing for all Jira ticket requirements
    MCP_CALL: add_comment with content:
      "📋 *Tests Written*

      Comprehensive tests created covering:
      - {test_coverage_summary}
      - Edge cases and error handling
      - Integration scenarios

      Proceeding with implementation..."
  </test_writing_phase>

  <implementation_phase>
    FOR each implementation step:
      IMPLEMENT: Specific functionality to make tests pass
      UPDATE: Tests if requirements evolve
      MCP_CALL: add_comment with content:
        "🔧 *Implementation Progress*

        ✅ {completed_functionality}
        ⏳ {current_work}

        Tests passing: {test_status}"
  </implementation_phase>

  <verification_phase>
    RUN: Complete test suite for ticket functionality
    VERIFY: All tests pass and no regressions
    MCP_CALL: add_comment with content:
      "✅ *Tests Verified*

      All tests passing:
      - {test_results_summary}
      - No regressions detected
      - Implementation complete

      Finalizing changes..."
  </verification_phase>
</tdd_execution>

<execution_order>
  <follow_execute_task>
    REFERENCE: @.agent-os/instructions/core/execute-task.md steps 5-6
    EXECUTE: Exact same TDD workflow process
    ADAPT: Progress comments to use Jira MCP commenting
    MAINTAIN: All quality standards and testing requirements
  </follow_execute_task>
</execution_order>

<instructions>
  ACTION: Follow execute-task.md TDD workflow exactly
  ADAPT: Progress tracking to use Jira MCP comments
  MAINTAIN: All testing standards and quality requirements
  UPDATE: Jira ticket with progress at each major milestone
</instructions>

</step>

<step number="6" name="completion_summary">

### Step 6: Completion Summary and Registry Update

Post comprehensive completion summary to Jira ticket and update local registry.

<completion_summary>
  <change_summary>
    GENERATE: Summary of all changes made
    INCLUDE: Files modified, tests added, functionality implemented
    DOCUMENT: Any important decisions or considerations
    LIST: Commits made during implementation
  </change_summary>

  <final_comment>
    MCP_CALL: add_comment with content:
      "🎉 *Ticket Complete*

      h2. Summary
      {implementation_summary}

      h2. Changes Made
      {files_modified}

      h2. Tests Added
      {test_coverage}

      h2. Commits
      {commit_links}

      h2. Notes
      {additional_notes}

      Ticket implementation complete and all tests passing. Ready for review."
    PURPOSE: Provide complete summary for team review
  </final_comment>
</completion_summary>

<status_transition>
  <completion_workflow>
    GET: Available transitions for current ticket
    IF "Done" transition available:
      PROMPT: User to confirm ticket completion
      IF user_confirms:
        MCP_CALL: transition_issue to "Done"
        ADD: Resolution comment if required by workflow
    ELSE:
      MCP_CALL: transition_issue to highest completion state available
      NOTE: Manual transition may be needed for final closure
  </completion_workflow>
</status_transition>

<registry_update>
  <issues_md_update>
    LOCATE: Appropriate issues.md file in spec folder
    UPDATE: Jira ticket entry with completion status:
      - [x] **{ticket_summary}**
        - Ticket: {key} - {jira_url}
        - Completed: {current_date}
        - Status: {final_status}
        - Summary: {brief_summary}
        - Files: {modified_files}
        - Commits: {commit_hashes}
  </issues_md_update>
</registry_update>

<instructions>
  ACTION: Create comprehensive completion summary with Jira markup
  POST: Final comment to Jira ticket with all details
  TRANSITION: Ticket to completion state if possible
  UPDATE: Local issues.md registry with completion status
</instructions>

</step>

</process_flow>

<post_flight_check>
  EXECUTE: @.agent-os/instructions/meta/post-flight.md
</post_flight_check>