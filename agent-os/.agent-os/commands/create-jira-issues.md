# Create Jira Issues

Create Jira tickets from Agent OS tasks with full spec context for team collaboration.

**Features:**
- Automatically detects and prevents duplicate ticket creation
- Tracks all created tickets in spec folder registry
- Links tickets to corresponding spec documentation
- Maintains creation history for project tracking
- Supports both checklist and sub-task strategies

Refer to the instructions located in this file:
@.agent-os/instructions/core/create-jira-issues.md

## Issue Tracking

All created Jira tickets are automatically tracked in the spec folder's `issues.md` file. This ensures:
- No duplicate tickets are created accidentally
- Clear visibility of what tickets belong to each spec
- Easy tracking of ticket status and completion
- Historical record of ticket creation activities
- Integration with GitHub issues in the same registry

The issue registry is located at: `.agent-os/specs/YYYY-MM-DD-spec-name/issues.md`

## MCP Server Requirements

**Current Status**: ✅ Atlassian MCP server is configured and operational.

**Available Capabilities**:
- **Issue Creation**: Create individual Jira tickets with complete field mapping
- **Batch Creation**: Create multiple related tickets efficiently with `jira_batch_create_issues`
- **Project Integration**: Automatic project key detection and validation
- **Field Management**: Support for all standard fields (summary, description, issue type, priority, assignee)
- **Custom Fields**: Access to project-specific custom fields and components
- **Duplicate Prevention**: Query existing tickets to prevent duplicate creation
- **Link Management**: Create issue links and epic relationships between tickets

**Key MCP Tools Used**:
- `jira_create_issue` - Create individual tickets with full field support
- `jira_batch_create_issues` - Efficiently create multiple related tickets
- `jira_search` - Check for existing tickets to prevent duplicates
- `jira_create_issue_link` - Link related tickets together
- `jira_link_to_epic` - Associate tickets with epics
- `jira_search_fields` - Discover available custom fields for projects
- `jira_get_project_issues` - Validate project access and review existing tickets

**Integration Benefits**:
- **Seamless Creation**: Direct ticket creation without manual Jira interface
- **Spec Alignment**: Automatically populate tickets with spec context and requirements
- **Team Collaboration**: Immediate ticket availability for team assignment and tracking
- **Registry Sync**: Automatic tracking of created tickets in local issue registry