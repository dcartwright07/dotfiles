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