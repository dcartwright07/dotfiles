# Work on GitHub Issue

Execute a GitHub issue using Agent OS TDD workflow with automatic progress tracking and completion updates.

**Features:**
- **Interactive Issue Selection** - Browse and select from available GitHub issues
- **GitHub CLI Integration** - Uses `gh` CLI for reliable issue fetching and commenting
- **Auto-Repository Detection** - Automatically detects repository from git configuration
- **Issue Registry Integration** - Leverages existing issues.md registry for context
- **TDD Workflow Execution** - Follows the same proven workflow as execute-task.md
- **Progress Tracking** - Automatically comments on GitHub issues with progress updates
- **Completion Summary** - Adds detailed summary comment when work is complete
- **Registry Updates** - Updates local issue registry with completion status

**Requirements:**
- GitHub CLI (`gh`) installed and authenticated
- Access to target GitHub repository
- Existing Agent OS spec folder with technical context

**Key Benefits:**
- **Seamless Integration** - Work directly on GitHub issues without manual task creation
- **Automatic Updates** - Issue progress is automatically communicated to the team
- **Context Preservation** - Leverages existing spec context for technical requirements
- **TDD Enforcement** - Ensures proper test-driven development workflow
- **Team Visibility** - Real-time progress updates keep stakeholders informed

Refer to the instructions located in this file:
@.agent-os/instructions/core/work-on-github-issue.md

## Workflow Overview

1. **Issue Discovery**: Fetches available GitHub issues from the repository
2. **Interactive Selection**: User chooses which specific issue to work on
3. **Issue Analysis**: Parses GitHub issue content and requirements
4. **TDD Execution**: Follows the complete execute-task.md workflow
5. **Progress Updates**: Adds comments to GitHub issue during execution
6. **Completion**: Posts summary comment and updates registry

## Progress Tracking

The command automatically adds comments to the GitHub issue at key milestones:

- **🚀 Work Started**: When beginning work on the issue
- **📋 Tests Written**: After writing comprehensive tests
- **🔧 Implementation**: During feature/fix implementation
- **✅ Tests Passing**: When all tests are verified
- **🎉 Complete**: Final summary with links to changes

## Registry Integration

Updates the existing issues.md registry with:
- Work completion status and timestamp
- Links to commits, PRs, or modified files
- Summary of changes made
- Any relevant notes or blockers encountered

This ensures seamless integration with existing Agent OS issue tracking and project management workflows.