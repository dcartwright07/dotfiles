# Tech Stack

## Context

Global tech stack defaults for Agent OS projects, overridable in project-specific `.agent-os/product/tech-stack.md`.

## Frontend

### Web Applications
- **Language**: TypeScript (strict mode)
- **Framework**: Vue 3 with Composition API
- **UI Library**: PrimeVue (enterprise), custom components (simple projects)
- **Build Tool**: Vite
- **Package Manager**: pnpm
- **State Management**: Pinia
- **HTTP Client**: Axios
- **Testing**: Vitest (unit), Playwright (E2E)
- **Code Quality**: ESLint + Prettier
- **Import Strategy**: ES modules with path aliases (@/, @core/, @modules/)

### Mobile Applications
- **Framework**: Ionic Vue (Capacitor)
- **Platform Support**: iOS, Android, PWA
- **Native Features**: Camera, Geolocation, Push Notifications
- **Testing**: Playwright (E2E), Vitest (unit)

### Static Sites
- **Languages**: HTML5, CSS3, JavaScript
- **Styling**: Modern CSS with Flexbox/Grid, nested structure
- **Hosting**: GitHub Pages, Netlify
- **Forms**: Formspree, Netlify Forms

## Backend

### API Development
- **Language**: Go
- **Framework**: Gin (REST APIs)
- **Database**: Supabase, PostgreSQL
- **Documentation**: Swagger/OpenAPI
- **Authentication**: JWT, OAuth

### Alternative Stacks
- **Node.js**: For JavaScript-heavy integrations
- **PHP**: Laravel (for specific client requirements)

## Development Environment
- **Node Version**: 22 LTS
- **Package Manager**: pnpm (primary), npm (fallback)
- **Git Workflow**: main → staging → dev branches
- **Testing**: Required before deployment
- **Type Checking**: vue-tsc for Vue projects

## Hosting & Deployment
- **Web Apps**: Heroku, Netlify, Vercel
- **Static Sites**: GitHub Pages, Netlify
- **APIs**: Heroku, Railway, Supabase Edge Functions
- **Region**: US-based (adjust per user base)

## Quality Assurance
- **Code Linting**: ESLint with Vue/TypeScript configs
- **Formatting**: Prettier
- **Type Checking**: TypeScript strict mode
- **Testing**: Vitest (unit), Playwright (E2E), coverage required
- **Pre-commit**: ESLint + type checking
