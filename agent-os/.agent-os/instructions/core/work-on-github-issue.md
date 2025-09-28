---
description: Execute a GitHub issue using Agent OS TDD workflow with progress tracking
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# GitHub Issue Execution Rules

## Overview

Execute a GitHub issue following the same proven TDD workflow as execute-task.md with automatic progress tracking and team communication.

<pre_flight_check>
  EXECUTE: @.agent-os/instructions/meta/pre-flight.md
</pre_flight_check>

<process_flow>

<step number="1" name="github_setup_validation">

### Step 1: GitHub Setup and Repository Validation

Verify GitHub CLI access and repository configuration before proceeding.

<github_validation>
  <cli_check>
    - VERIFY: `gh auth status` shows authenticated user
    - VERIFY: `gh repo view` returns current repository info
    - ERROR: If not authenticated, prompt user to run `gh auth login`
  </cli_check>
  <repository_detection>
    - DETECT: Repository from git remote origin
    - VERIFY: User has issue read/write permissions
    - EXTRACT: Repository owner and name for API calls
  </repository_detection>
</github_validation>

<error_handling>
  IF github_cli_not_available:
    ERROR: "GitHub CLI not found. Please install gh CLI: https://cli.github.com"
  IF not_authenticated:
    ERROR: "GitHub authentication required. Run: gh auth login"
  IF no_repository:
    ERROR: "No GitHub repository detected. Ensure you're in a git repository with GitHub remote."
  IF no_permissions:
    ERROR: "Insufficient repository permissions. Need read/write access to issues."
</error_handling>

<instructions>
  ACTION: Validate GitHub CLI and repository access
  VERIFY: Authentication and permissions are working
  EXTRACT: Repository information for issue operations
  CONTINUE: Only if all validation checks pass
</instructions>

</step>

<step number="2" name="issue_discovery_selection">

### Step 2: Issue Discovery and Selection

Fetch available GitHub issues and present interactive selection interface to user.

<issue_fetching>
  <fetch_open_issues>
    COMMAND: `gh issue list --json number,title,body,labels,assignees,milestone,createdAt,updatedAt --limit 50`
    PARSE: JSON response into structured issue list
    FILTER: Remove issues already marked complete in registry
  </fetch_open_issues>
  <registry_context>
    CHECK: Existing @.agent-os/specs/*/issues.md files for GitHub issues
    EXTRACT: Previously worked issues and their status
    ENRICH: Issue list with registry context and completion status
  </registry_context>
</issue_fetching>

<selection_interface>
  <display_format>
    FOR each available issue:
      SHOW: "#{number}: {title}"
      SHOW: "  Labels: {labels}"
      SHOW: "  Status: {registry_status or 'Available'}"
      SHOW: "  Created: {createdAt}"
  </display_format>
  <user_interaction>
    PROMPT: "Which GitHub issue would you like to work on?"
    ACCEPT: Issue number selection from user
    VALIDATE: Selected issue exists and is accessible
  </user_interaction>
</selection_interface>

<instructions>
  ACTION: Fetch and display available GitHub issues
  PRESENT: Clear selection interface with issue details
  AWAIT: User selection of specific issue to work on
  VALIDATE: Selected issue is accessible and appropriate
</instructions>

</step>

<step number="3" name="issue_analysis_preparation">

### Step 3: Issue Analysis and Task Preparation

Fetch full issue details and convert to Agent OS task format for execution.

<issue_details_fetch>
  <full_issue_data>
    COMMAND: `gh issue view {selected_number} --json number,title,body,labels,assignees,milestone,comments,createdAt,updatedAt,url`
    EXTRACT: Complete issue information including description and comments
    PARSE: GitHub markdown formatting in body and comments
  </full_issue_data>
  <content_analysis>
    ANALYZE: Issue title for main objective
    EXTRACT: Acceptance criteria from issue body
    IDENTIFY: Technical requirements and constraints
    DETECT: Related issues or dependencies mentioned
  </content_analysis>
</issue_details_fetch>

<task_conversion>
  <main_task_creation>
    TITLE: Use GitHub issue title as primary task
    DESCRIPTION: Convert issue body to task description
    REQUIREMENTS: Extract acceptance criteria as sub-tasks
  </main_task_creation>
  <sub_task_generation>
    IF issue contains checklist items:
      CONVERT: Each checklist item to Agent OS sub-task
    ELSE:
      INFER: Logical sub-tasks from issue description:
        - "Write tests for {main_feature}"
        - "Implement {specific_functionality}"
        - "Verify all tests pass"
  </sub_task_generation>
</task_conversion>

<progress_notification>
  <initial_comment>
    COMMAND: `gh issue comment {issue_number} --body "🚀 **Started working on this issue**\n\nFollowing Agent OS TDD workflow:\n1. ✅ Issue analysis complete\n2. ⏳ Writing comprehensive tests\n3. ⏳ Implementing functionality\n4. ⏳ Verifying all tests pass\n\nWill provide updates as work progresses."`
    PURPOSE: Notify team that work has begun
  </initial_comment>
</progress_notification>

<instructions>
  ACTION: Fetch complete issue details and analyze requirements
  CONVERT: GitHub issue content to Agent OS task format
  NOTIFY: Team via GitHub comment that work has started
  PREPARE: Task structure for TDD workflow execution
</instructions>

</step>

<step number="4" subagent="context-fetcher" name="spec_context_review">

### Step 4: Spec Context Review

Use context-fetcher subagent to gather relevant spec context for the GitHub issue requirements.

<spec_detection>
  <auto_detection>
    SEARCH: Most recent spec folder in @.agent-os/specs/
    VERIFY: Spec folder contains relevant context for issue
    FALLBACK: Use current working directory context if no spec
  </auto_detection>
  <context_gathering>
    IF spec_folder_exists:
      REQUEST: context-fetcher to extract relevant sections from:
        - technical-spec.md related to issue requirements
        - best-practices.md for implementation approach
        - code-style.md for formatting guidelines
    ELSE:
      GATHER: Codebase context relevant to issue area
  </context_gathering>
</spec_detection>

<instructions>
  ACTION: Use context-fetcher subagent
  REQUEST: "Find spec context relevant to GitHub issue: {issue_title}
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

### Step 5: Execute TDD Workflow (Follow execute-task.md)

Execute the GitHub issue using the exact same workflow as execute-task.md steps 5-6.

<tdd_execution>
  <test_writing_phase>
    EXECUTE: Test writing for all GitHub issue requirements
    COMMENT: `gh issue comment {issue_number} --body "📋 **Tests Written**\n\nComprehensive tests created covering:\n- {test_coverage_summary}\n- Edge cases and error handling\n- Integration scenarios\n\nProceeding with implementation..."`
  </test_writing_phase>

  <implementation_phase>
    FOR each implementation step:
      IMPLEMENT: Specific functionality to make tests pass
      UPDATE: Tests if requirements evolve
      COMMENT: `gh issue comment {issue_number} --body "🔧 **Implementation Progress**\n\n✅ {completed_functionality}\n⏳ {current_work}\n\nTests passing: {test_status}"`
  </implementation_phase>

  <verification_phase>
    RUN: Complete test suite for issue functionality
    VERIFY: All tests pass and no regressions
    COMMENT: `gh issue comment {issue_number} --body "✅ **Tests Verified**\n\nAll tests passing:\n- {test_results_summary}\n- No regressions detected\n- Implementation complete\n\nFinalizing changes..."`
  </verification_phase>
</tdd_execution>

<execution_order>
  <follow_execute_task>
    REFERENCE: @.agent-os/instructions/core/execute-task.md steps 5-6
    EXECUTE: Exact same TDD workflow process
    ADAPT: Progress comments to use GitHub issue commenting
    MAINTAIN: All quality standards and testing requirements
  </follow_execute_task>
</execution_order>

<instructions>
  ACTION: Follow execute-task.md TDD workflow exactly
  ADAPT: Progress tracking to use GitHub issue comments
  MAINTAIN: All testing standards and quality requirements
  UPDATE: GitHub issue with progress at each major milestone
</instructions>

</step>

<step number="6" name="completion_summary">

### Step 6: Completion Summary and Registry Update

Post comprehensive completion summary to GitHub issue and update local registry.

<completion_summary>
  <change_summary>
    GENERATE: Summary of all changes made
    INCLUDE: Files modified, tests added, functionality implemented
    DOCUMENT: Any important decisions or considerations
    LIST: Commits made during implementation
  </change_summary>

  <final_comment>
    COMMAND: `gh issue comment {issue_number} --body "🎉 **Issue Complete**\n\n## Summary\n{implementation_summary}\n\n## Changes Made\n{files_modified}\n\n## Tests Added\n{test_coverage}\n\n## Commits\n{commit_links}\n\n## Notes\n{additional_notes}\n\nIssue implementation complete and all tests passing. Ready for review."`
    PURPOSE: Provide complete summary for team review
  </final_comment>
</completion_summary>

<registry_update>
  <issues_md_update>
    LOCATE: Appropriate issues.md file in spec folder
    UPDATE: GitHub issue entry with completion status:
      - [x] **{issue_title}**
        - Issue: #{number} - {github_url}
        - Completed: {current_date}
        - Status: Complete
        - Summary: {brief_summary}
        - Files: {modified_files}
        - Commits: {commit_hashes}
  </issues_md_update>

  <optional_issue_close>
    IF user_confirms AND issue_fully_resolved:
      COMMAND: `gh issue close {issue_number} --comment "Resolved via Agent OS implementation. All requirements met and tests passing."`
    ELSE:
      LEAVE: Issue open for team review and manual closure
  </optional_issue_close>
</registry_update>

<instructions>
  ACTION: Create comprehensive completion summary
  POST: Final comment to GitHub issue with all details
  UPDATE: Local issues.md registry with completion status
  OPTIONALLY: Close issue if user confirms and work is complete
</instructions>

</step>

</process_flow>

<post_flight_check>
  EXECUTE: @.agent-os/instructions/meta/post-flight.md
</post_flight_check>