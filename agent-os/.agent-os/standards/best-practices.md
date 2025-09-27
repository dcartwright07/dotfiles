# Development Best Practices

## Context

Global development guidelines for Agent OS projects.

<conditional-block context-check="core-principles">
IF this Core Principles section already read in current context:
  SKIP: Re-reading this section
  NOTE: "Using Core Principles already in context"
ELSE:
  READ: The following principles

## Core Principles

### Keep It Simple
- Implement code in the fewest lines possible
- Avoid over-engineering solutions
- Choose straightforward approaches over clever ones

### Optimize for Readability
- Prioritize code clarity over micro-optimizations
- Write self-documenting code with clear variable names
- Add comments for "why" not "what"

### DRY (Don't Repeat Yourself)
- Extract repeated business logic to private methods
- Extract repeated UI markup to reusable components
- Create utility functions for common operations

### Project Architecture Patterns

#### Modular Enterprise Structure (for complex projects)
```
src/
├── app/                 # App-level configuration
├── core/               # Shared libraries and utilities
│   ├── api/           # API base classes and configurations
│   ├── forms/         # Form components and validation
│   ├── helpers/       # Utility functions (tryCatch, extractError)
│   └── types/         # Global TypeScript types
└── modules/           # Feature modules
    ├── users/
    │   ├── components/
    │   ├── composables/
    │   ├── managers/   # Business logic classes
    │   ├── services/   # API integration services
    │   └── types/
    └── orders/
        ├── components/
        ├── managers/
        └── services/
```

#### Simple Project Structure (for smaller projects)
```
src/
├── components/        # Vue components
├── composables/      # Reusable composition functions
├── services/         # API services
├── types/           # TypeScript types
├── utils/           # Utility functions
└── views/           # Page components
```

### Service Layer Architecture
- Create services that extend API base classes
- Return tuple patterns: `[error, data]` from service methods
- Use `tryCatch` helper for consistent error handling
- Manager classes consume services for business logic

### Vue Component Best Practices
- Always place `<script setup lang="ts">` at the top of .vue files
- Use composables for reusable logic, keep components focused on presentation
- Define clear interfaces for Props and Emits
- Use `defineModel<T>()` for v-model implementation
- Extract complex business logic to Manager classes

### Manager Class Pattern
```typescript
export class UserManager {
    constructor(
        private userService: UserService,
        private notificationService: NotificationService
    ) {}

    async createUser(userData: CreateUserRequest): Promise<User | null> {
        const [error, user] = await this.userService.create(userData)

        if (error) {
            this.handleError(error)
            return null
        }

        await this.notificationService.sendWelcomeEmail(user)
        return user
    }
}
```

### Service Layer Pattern
```typescript
export class UserService extends InternalApi {
    async getUser(id: number): Promise<BaseResponse<User>> {
        if (!id) throw new ParameterNotFound('User ID is required')

        const [httpError, httpResponse] = await tryCatch(
            this.get(`users/${id}`)
        )

        const error = httpError ? extractMessageFromError(httpError) : null
        return [error, httpResponse?.data as User]
    }
}
```

### Form Validation Patterns
- Use composables for form field logic (`useFormField`)
- Implement FieldConfig<T> for complex enterprise forms
- Use simple v-model for basic forms
- Always provide TypeScript interfaces for form data

### Testing Strategy
- Use Vitest for unit testing Vue components and utilities
- Use Playwright for E2E testing across projects
- Test Manager classes with mocked services
- Maintain test coverage requirements
- Run tests before deployment

### Mobile Development (Ionic Vue)
- Use Ionic Vue components consistently
- Implement proper PWA patterns with service workers
- Handle platform-specific features (camera, geolocation)
- Test on actual devices, not just simulators

### Documentation
- Write clear, concise documentation for all public APIs
- Include examples in documentation
- Write documentation for each library in a Readme file in the library's root directory
- Include a link to the documentation in the project's README file
- Include a link to each library's documentation in the project's README file
</conditional-block>

<conditional-block context-check="dependencies" task-condition="choosing-external-library">
IF current task involves choosing an external library:
  IF Dependencies section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using Dependencies guidelines already in context"
  ELSE:
    READ: The following guidelines
ELSE:
  SKIP: Dependencies section not relevant to current task

## Dependencies
- Avoid adding dependencies unless they are absolutely necessary
- Avoid adding dependencies that are not actively maintained
- Avoid adding dependencies that are not well-supported
- Keep the project's dependencies as small as possible

### Choose Libraries Wisely
When needing to add third-party dependencies:
- Select the most popular and actively maintained option
- Check the library's GitHub repository for:
  - Recent commits (within last 6 months)
  - Active issue resolution
  - Number of stars/downloads
  - Clear documentation
</conditional-block>
