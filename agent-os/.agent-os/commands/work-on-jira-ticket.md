# Work on Jira Ticket

Execute a Jira ticket using Agent OS TDD workflow with automatic progress tracking and completion updates.

**Features:**
- **Interactive Ticket Selection** - Browse and select from available Jira tickets
- **Atlassian MCP Integration** - Uses Atlassian MCP server for reliable ticket operations
- **Ticket Registry Integration** - Leverages existing issues.md registry for context
- **TDD Workflow Execution** - Follows the same proven workflow as execute-task.md
- **Progress Tracking** - Automatically updates Jira tickets with progress comments
- **Status Management** - Updates ticket status as work progresses
- **Completion Summary** - Adds detailed summary and transitions ticket to done
- **Registry Updates** - Updates local issue registry with completion status

**Requirements:**
- Atlassian MCP server configured and authenticated
- Access to target Jira project
- Existing Agent OS spec folder with technical context

**Key Benefits:**
- **Seamless Integration** - Work directly on Jira tickets without manual task creation
- **Automatic Updates** - Ticket progress is automatically communicated to the team
- **Context Preservation** - Leverages existing spec context for technical requirements
- **TDD Enforcement** - Ensures proper test-driven development workflow
- **Team Visibility** - Real-time progress updates keep stakeholders informed
- **Workflow Integration** - Respects Jira workflows and status transitions

Refer to the instructions located in this file:
@.agent-os/instructions/core/work-on-jira-ticket.md

## Workflow Overview

1. **Ticket Discovery**: Fetches available Jira tickets from the project
2. **Interactive Selection**: User chooses which specific ticket to work on
3. **Ticket Analysis**: Parses Jira ticket content and requirements
4. **TDD Execution**: Follows the complete execute-task.md workflow
5. **Progress Updates**: Adds comments and updates status in Jira
6. **Completion**: Posts summary comment and transitions to done

## Progress Tracking

The command automatically updates the Jira ticket at key milestones:

- **🚀 Work Started**: Transitions to "In Progress" and adds work log
- **📋 Tests Written**: Comments with test coverage details
- **🔧 Implementation**: Updates with implementation progress
- **✅ Tests Passing**: Confirms all tests verified
- **🎉 Complete**: Final summary and transition to done

## Registry Integration

Updates the existing issues.md registry with:
- Work completion status and timestamp
- Links to commits, PRs, or modified files
- Summary of changes made
- Jira ticket status and resolution details

This ensures seamless integration with existing Agent OS issue tracking and project management workflows.

## MCP Server Requirements

**Current Status**: ✅ Atlassian MCP server is configured and operational.

**Available Capabilities**:
- **Ticket Search & Discovery**: Use `jira_search` with JQL queries to find available tickets
- **Ticket Details**: Retrieve complete ticket information including description, status, assignee
- **Status Transitions**: Get available transitions and update ticket status throughout workflow
- **Progress Updates**: Add comments to tickets with progress updates and work logs
- **Field Management**: Access to all standard and custom fields for comprehensive ticket handling
- **User Profile Access**: Retrieve user information for proper assignee management

**Key MCP Tools Used**:
- `jira_search` - Find tickets with JQL queries
- `jira_get_issue` - Get detailed ticket information
- `jira_get_transitions` - Get available status transitions for tickets
- `jira_transition_issue` - Update ticket status (To Do → In Progress → Done)
- `jira_add_comment` - Add progress updates and completion summaries
- `jira_add_worklog` - Track time spent on tickets
- `jira_update_issue` - Update ticket fields as needed

**Workflow Integration**: The MCP server supports the complete TDD workflow with automatic Jira updates at each milestone, ensuring seamless team visibility and proper ticket lifecycle management.