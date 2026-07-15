# CSS Style Guide

## UI Design Standards

For comprehensive guidelines on UI colors, shadows, and visual depth:
- **[Color Palette System](../ui-design/color-palette.md)** - Complete color palette structure, 60-30-10 rule, shade variations
- **[Shadows & Depth](../ui-design/shadows-and-depth.md)** - Color layering, shadow systems, gradient techniques

## Nested CSS Structure (Preferred)
- Use nested CSS for component-specific styles
- Use 4 spaces for indentation
- Place nested elements on new lines with proper indentation
- Group related styles together within parent selectors
- Use semantic class names that describe purpose, not appearance

## Modern CSS Features
- Use CSS custom properties (variables) for theming
- Use flexbox and CSS Grid for layout
- Use logical properties (margin-inline, padding-block) when appropriate
- Use modern CSS functions (clamp, min, max) for responsive design

## Vue Scoped Styles Example

```vue
<style scoped>
.form-field {
    margin-bottom: 1rem;

    .field-label {
        display: block;
        margin-bottom: 0.25rem;
        font-weight: 500;
        color: var(--text-primary);
    }

    .field-input {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 0.375rem;
        font-size: 1rem;

        &:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-color-alpha);
        }

        &.error {
            border-color: var(--error-color);

            &:focus {
                border-color: var(--error-color);
                box-shadow: 0 0 0 3px var(--error-color-alpha);
            }
        }
    }

    .field-error {
        margin-top: 0.25rem;
        font-size: 0.875rem;
        color: var(--error-color);
    }

    @media (max-width: 768px) {
        margin-bottom: 0.75rem;

        .field-input {
            padding: 0.625rem;
            font-size: 0.9rem;
        }
    }
}
</style>
```

## Ionic Vue Styles Example

```vue
<style scoped>
.xps-field-container {
    margin-bottom: 1rem;

    .xps-input-item {
        --background: transparent;
        --border-radius: 8px;
        --padding-start: 0;
        --padding-end: 0;

        &--error {
            --border-color: var(--ion-color-danger);
        }
    }

    .xps-field-error {
        color: var(--ion-color-danger);
        font-size: 0.875rem;
        margin-top: 0.25rem;
        padding-left: 16px;
    }

    .xps-field-hint {
        color: var(--ion-color-medium);
        font-size: 0.75rem;
        margin-top: 0.125rem;
        padding-left: 16px;
    }
}
</style>
```

## Component-Level Theming

```css
.filter-modal-content {
    --padding-start: 16px;
    --padding-end: 16px;

    .filter-section {
        margin-bottom: 32px;
        margin-top: 1rem;

        .filter-section-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--ion-color-dark);
            margin: 0 0 16px 0;
        }
    }

    .chip-group {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .time-range-section {
        margin-top: 16px;

        ion-item {
            --background: transparent;
            --padding-start: 0;
            --padding-end: 0;
            --inner-padding-start: 0;
            --inner-padding-end: 0;
        }

        ion-range {
            --bar-height: 4px;
            --bar-background: var(--ion-color-light-shade);
            --bar-background-active: var(--ion-color-dark);
            --knob-background: var(--ion-color-dark);
            --knob-size: 20px;
            --pin-background: var(--ion-color-dark);
            --pin-color: var(--ion-color-light);
        }
    }

    @media (max-width: 768px) {
        --padding-start: 20px;
        --padding-end: 20px;

        .filter-section {
            margin-bottom: 28px;

            .filter-section-title {
                font-size: 16px;
            }
        }

        .chip-group {
            gap: 0.5rem;
        }
    }
}
```

## Global CSS Variables

```css
:root {
    /* Colors */
    --primary-color: #0066cc;
    --primary-color-alpha: rgba(0, 102, 204, 0.1);
    --error-color: #dc3545;
    --error-color-alpha: rgba(220, 53, 69, 0.1);
    --success-color: #28a745;
    --warning-color: #ffc107;

    /* Text */
    --text-primary: #212529;
    --text-secondary: #6c757d;
    --text-muted: #8e8e93;

    /* Borders */
    --border-color: #dee2e6;
    --border-radius: 0.375rem;

    /* Spacing */
    --space-xs: 0.25rem;
    --space-sm: 0.5rem;
    --space-md: 1rem;
    --space-lg: 1.5rem;
    --space-xl: 2rem;

    /* Shadows */
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

@media (prefers-color-scheme: dark) {
    :root {
        --text-primary: #e0e0e0;
        --text-secondary: #a8a8a8;
        --border-color: #404040;
    }
}
```

## Naming Conventions
- Use semantic class names (`.form-field`, `.navigation-menu`)
- Use BEM methodology for complex components
- Use kebab-case for CSS classes
- Prefix component-specific classes with component name
- Use descriptive names that indicate purpose, not appearance