# Create GitHub Issues

Create GitHub issues from Agent OS tasks with full spec context for team collaboration.

**Features:**
- **GitHub CLI Integration** - Uses `gh` CLI for reliable issue creation and management
- **Auto-Repository Detection** - Automatically detects repository from git configuration
- **Milestone Management** - Creates and assigns issues to milestones for better organization
- **Project Board Integration** - Adds issues to GitHub projects with proper type classification
- **Issue Type Classification** - Categorizes issues as Features or Tasks automatically
- **Duplicate Prevention** - Automatically detects and prevents duplicate issue creation
- **Comprehensive Tracking** - Tracks all created issues in spec folder registry with full metadata
- **Smart Configuration** - Pre-fills settings from git config and repository information

**Requirements:**
- GitHub CLI (`gh`) installed and authenticated
- Access to target GitHub repository
- Optional: GitHub Projects setup for enhanced project management

Refer to the instructions located in this file:
@.agent-os/instructions/core/create-github-issues.md

## Issue Tracking

All created GitHub issues are automatically tracked in the spec folder's `issues.md` file. This ensures:
- No duplicate issues are created accidentally
- Clear visibility of what issues belong to each spec
- Easy tracking of issue status, milestones, and project assignments
- Historical record of issue creation activities with full metadata
- Integration tracking between GitHub issues and Jira tickets

**Enhanced Registry Format:**
The registry now includes comprehensive metadata:
- Issue numbers and URLs
- Milestone assignments and URLs
- Project board assignments and status
- Issue type classification (Feature/Task)
- Creation dates and assignees
- Historical tracking of batch operations

The issue registry is located at: `.agent-os/specs/YYYY-MM-DD-spec-name/issues.md`

## Workflow Integration

1. **Auto-Detection**: Automatically detects repository from git configuration
2. **Milestone Creation**: Creates a milestone named after the spec for organization
3. **Project Assignment**: Adds all issues to the active GitHub project in Backlog status
4. **Type Classification**: Sets issue types as Feature or Task for proper project management
5. **Registry Update**: Tracks all created issues with full metadata for future reference

This creates a seamless workflow from spec to tracked, organized GitHub issues ready for development.