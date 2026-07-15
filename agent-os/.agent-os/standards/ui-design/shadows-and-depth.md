# UI Shadows and Depth Standards

## Context

Guidelines for creating visual depth and hierarchy in UI components using color layering, shadows, and gradients.

## Color Layering for Depth

### The 4-Shade System

Create visual hierarchy by applying progressively lighter shades to elements based on their importance.

**Step 1: Generate Shades**

Starting from any base color (e.g., gray-200, blue-500):
- **Shade 1 (Darkest):** Base color - 0.1 lightness
- **Shade 2 (Medium):** Base color (your starting point)
- **Shade 3 (Light):** Base color + 0.1 lightness
- **Shade 4 (Lightest):** Base color + 0.2 lightness (optional)

**Example:**
```css
/* Starting with gray-200 as base */
--shade-1: #e0e0e0;  /* Darkest - page background */
--shade-2: #eeeeee;  /* Medium - card backgrounds */
--shade-3: #f5f5f5;  /* Light - interactive elements */
--shade-4: #fafafa;  /* Lightest - selected/hover states */
```

**Step 2: Apply to Page Hierarchy**

- **Page background:** Use Shade 1 (darkest)
- **Container/card backgrounds:** Use Shade 2 (medium)
- **Interactive elements** (buttons, tabs, inputs): Use Shade 3 (light)
- **Selected/active/hover states:** Use Shade 4 (lightest)

**Step 3: Compensate Text & Icons**

**Critical Rule:** When you apply a lighter background to an element, increase text and icon lightness by the same amount.

This maintains proper contrast and prevents a muted appearance.

```css
/* Base container */
.container {
    background: var(--shade-2);
    color: var(--neutral-700);
}

/* Interactive element inside (one shade lighter) */
.button {
    background: var(--shade-3);  /* +0.1 lightness */
    color: var(--neutral-600);   /* +0.1 lightness for text */
}

/* Selected state (another shade lighter) */
.button.selected {
    background: var(--shade-4);  /* +0.2 lightness total */
    color: var(--neutral-500);   /* +0.2 lightness for text */
}
```

**Step 4: Border Removal**

- Remove borders from elements using Shade 3 or Shade 4
- The color contrast itself creates sufficient separation
- Keep borders only on Shade 1 or Shade 2 if absolutely necessary

### Element-Specific Applications

#### Tabs
```css
.tab-container {
    background: var(--shade-2);
}

.tab {
    background: transparent;
    color: var(--neutral-700);
    border: none;
    
    &:hover {
        background: var(--shade-3);
        color: var(--neutral-600);
    }
    
    &.active {
        background: var(--shade-3);
        color: var(--neutral-800);  /* Slightly darker for emphasis */
    }
}
```

#### Cards
```css
.card-wrapper {
    background: var(--shade-2);
    padding: 1rem;
}

.card-important-section {
    background: var(--shade-3);
    padding: 1rem;
    border: none;  /* No border needed */
}

.card.selected {
    background: var(--shade-3);
    box-shadow: var(--shadow-md);  /* Add shadow for emphasis */
}
```

#### Dropdowns & Buttons
```css
.dropdown {
    background: var(--shade-2);
    border: 1px solid var(--neutral-300);
}

.dropdown-item {
    background: transparent;
    color: var(--neutral-700);
    
    &:hover,
    &.highlighted {
        background: var(--shade-3);
        color: var(--neutral-600);
        border: none;
    }
}

/* Premium feel with gradient + shadow */
.button-premium {
    background: linear-gradient(to bottom, var(--shade-3), var(--shade-2));
    box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2);
    border: none;
}
```

#### Radio/Checkbox Options
```css
.option-container {
    background: var(--shade-2);
    display: flex;
    gap: 0.5rem;
}

.option {
    background: var(--shade-2);
    padding: 0.75rem;
    border: 1px solid var(--neutral-300);
    
    &.selected {
        background: var(--shade-3);
        border: none;
        color: var(--neutral-600);
    }
}
```

#### Tables
```css
.table {
    background: var(--shade-1);  /* Darker to push it deeper */
    border: 1px solid var(--neutral-300);
}

.table-row {
    &:hover {
        background: var(--shade-2);
    }
    
    &.selected {
        background: var(--shade-2);
    }
}
```

#### Navigation
```css
.nav {
    background: var(--shade-2);
}

.nav-item {
    background: var(--shade-3);
    color: var(--neutral-700);
    margin: 0.25rem;
    border: none;
    
    &.active {
        background: var(--shade-4);
        color: var(--neutral-600);
    }
}
```

### Emphasis Control

**To Emphasize (Bring Forward):**
- Use lighter shades (Shade 3 or 4)
- Elements appear to "pop" toward the user
- Use for important actions, selected states, focal points

**To De-Emphasize (Push Back):**
- Use darker shades (Shade 1 or 2)
- Elements recede into the background
- Use for less important content, disabled states, decorative elements

**Visual Hierarchy Example:**
```
Page (Shade 1 - recedes)
└── Main Container (Shade 2 - neutral)
    └── Card (Shade 2 - neutral)
        ├── Text (Shade 2 background)
        └── Call-to-Action Button (Shade 3 - pops forward)
            └── Hover State (Shade 4 - pops even more)
```

## Two-Layer Shadow System

Shadows create realistic depth by simulating light sources. Use two layers for best results:
1. **Top layer:** Light border or glow (simulates reflected light)
2. **Bottom layer:** Dark shadow (simulates cast shadow)

### Shadow Levels

#### Small Shadow (Subtle Depth)

**Use For:**
- Subtle elements
- Small cards
- Navigation items
- Tabs
- Profile cards (feels most natural)

**Specification:**
```css
.shadow-small {
    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.1),  /* Top highlight */
        0 1px 2px rgba(0, 0, 0, 0.1);            /* Bottom shadow */
}
```

**Parameters:**
- Top layer: 0-1px offset, soft, white/light color, low opacity (0.1-0.15)
- Bottom layer: 1-2px offset, soft blur, dark color, low opacity (0.1)

#### Medium Shadow (Standard Depth)

**Use For:**
- Standard cards
- Dropdowns
- Modals
- Most components (default choice)
- Dashboard cards

**Specification:**
```css
.shadow-medium {
    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.15),  /* Top highlight */
        0 3px 6px rgba(0, 0, 0, 0.15);            /* Bottom shadow */
}
```

**Parameters:**
- Top layer: Increase by 2-3px from small
- Bottom layer: Increase by 2-3px from small
- Opacity: Slightly higher (0.15-0.2)

#### Large Shadow (Prominent Depth)

**Use For:**
- Hover states
- Focused elements
- Important modals
- Floating action buttons
- Dragged elements

**Specification:**
```css
.shadow-large {
    box-shadow:
        inset 0 2px 0 rgba(255, 255, 255, 0.2),  /* Top highlight */
        0 6px 12px rgba(0, 0, 0, 0.2);           /* Bottom shadow */
}
```

**Parameters:**
- Top layer: Push by a few more pixels (2px+)
- Bottom layer: Push by a few more pixels (6px+)
- Opacity: Higher for more dramatic effect (0.2-0.25)

### Shadow Selection Guide

**Component-Specific Recommendations:**

| Component | Shadow Level | Reasoning |
|-----------|-------------|-----------|
| Profile cards | Small | Feels most natural and subtle |
| Dashboard cards | Medium | Default, balanced depth |
| Hover states | Large | Interactive feedback |
| Modals | Large | Needs to clearly float above |
| Dropdowns | Medium | Clear but not overwhelming |
| Tooltips | Small | Subtle, non-intrusive |
| Buttons (rest) | None or Small | Minimal at rest |
| Buttons (hover) | Medium | Feedback on interaction |
| FAB (Floating Action) | Large | Always prominent |

### Dark Mode Adaptation

Shadows work best in light mode. For dark mode:

**Reduce Shadow Opacity:**
```css
@media (prefers-color-scheme: dark) {
    .shadow-small {
        box-shadow:
            inset 0 1px 0 rgba(255, 255, 255, 0.05),  /* Reduced */
            0 1px 2px rgba(0, 0, 0, 0.3);             /* Increased */
    }
    
    .shadow-medium {
        box-shadow:
            inset 0 1px 0 rgba(255, 255, 255, 0.08),
            0 3px 6px rgba(0, 0, 0, 0.4);
    }
    
    .shadow-large {
        box-shadow:
            inset 0 2px 0 rgba(255, 255, 255, 0.1),
            0 6px 12px rgba(0, 0, 0, 0.5);
    }
}
```

**Alternative: Use Color Layering:**
In dark mode, color layering often works better than shadows. Lighter backgrounds create depth without heavy shadows.

## Gradient Enhancement

### When to Use Gradients

**Best For:**
- Dropdowns
- Buttons
- Important interactive elements
- Creating "light hitting from top" effect
- Making linear elements feel more dynamic

**Avoid For:**
- Large backgrounds (can feel heavy)
- Text areas (reduces readability)
- Overuse (becomes distracting)

### Implementation Steps

**Step 1: Create Linear Gradient (Top to Bottom)**

```css
.gradient-element {
    background: linear-gradient(
        to bottom,
        #f5f5f5,  /* Top: lighter shade (base + 0.1-0.2 lightness) */
        #e5e5e5   /* Bottom: darker shade (base - 0.05-0.1 lightness) */
    );
}
```

**Step 2: Add Lighter Inner Shadow on Top Edge**

This creates the "shiny highlight up top" effect:

```css
.gradient-element {
    background: linear-gradient(to bottom, #f5f5f5, #e5e5e5);
    box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.3);
}
```

**Parameters:**
- Position: `inset 0 1px 0`
- Color: White or very light color
- Opacity: 0.2-0.4

**Step 3: Optional - Add Standard Shadow at Bottom**

Reinforces elevation:

```css
.gradient-element {
    background: linear-gradient(to bottom, #f5f5f5, #e5e5e5);
    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.3),  /* Top highlight */
        0 2px 4px rgba(0, 0, 0, 0.1);            /* Bottom shadow */
}
```

### Complete Examples

#### Premium Dropdown
```css
.dropdown-premium {
    background: linear-gradient(
        to bottom,
        var(--neutral-50),
        var(--neutral-100)
    );
    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.4),  /* Shiny top */
        0 3px 6px rgba(0, 0, 0, 0.15);           /* Depth shadow */
    border: 1px solid var(--neutral-300);
    border-radius: 0.5rem;
}
```

#### Glossy Button
```css
.button-glossy {
    background: linear-gradient(
        to bottom,
        var(--primary-400),
        var(--primary-600)
    );
    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.3),
        0 2px 4px rgba(0, 0, 0, 0.2);
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 0.375rem;
    
    &:hover {
        background: linear-gradient(
            to bottom,
            var(--primary-500),
            var(--primary-700)
        );
        box-shadow:
            inset 0 1px 0 rgba(255, 255, 255, 0.3),
            0 4px 8px rgba(0, 0, 0, 0.25);
    }
    
    &:active {
        box-shadow:
            inset 0 2px 4px rgba(0, 0, 0, 0.2),  /* Inverted - pushed in */
            0 1px 2px rgba(0, 0, 0, 0.1);
    }
}
```

#### Subtle Card
```css
.card-subtle {
    background: linear-gradient(
        to bottom,
        var(--neutral-0),
        var(--neutral-50)
    );
    box-shadow:
        inset 0 1px 0 rgba(255, 255, 255, 0.8),
        0 2px 4px rgba(0, 0, 0, 0.08);
    border-radius: 0.5rem;
    padding: 1.5rem;
}
```

## Combining Techniques

### Layered Component Example

```css
.advanced-card {
    /* Page background: Shade 1 */
    
    /* Card container: Shade 2 */
    background: var(--shade-2);
    padding: 1.5rem;
    border-radius: 0.5rem;
    box-shadow: var(--shadow-small);
    
    .card-header {
        /* Important section: Shade 3 */
        background: linear-gradient(
            to bottom,
            var(--shade-3),
            var(--shade-2)
        );
        box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2);
        padding: 1rem;
        margin: -1.5rem -1.5rem 1rem -1.5rem;
        border-radius: 0.5rem 0.5rem 0 0;
        border: none;
    }
    
    .card-action {
        /* CTA button: Shade 4 on hover */
        background: var(--primary-500);
        color: white;
        box-shadow: var(--shadow-small);
        border: none;
        
        &:hover {
            background: var(--primary-600);
            box-shadow: var(--shadow-medium);
            transform: translateY(-1px);
        }
        
        &:active {
            transform: translateY(0);
            box-shadow: var(--shadow-small);
        }
    }
}
```

## Best Practices Summary

### Color Layering
- [ ] Create 3-4 shades from base color
- [ ] Apply darker shades to page backgrounds
- [ ] Apply lighter shades to important elements
- [ ] Compensate text/icon colors when changing backgrounds
- [ ] Remove borders from elements using lighter shades
- [ ] Use layering to control visual emphasis

### Shadows
- [ ] Use two-layer shadows (top highlight + bottom shadow)
- [ ] Choose appropriate shadow level (small, medium, large)
- [ ] Small shadows for subtle elements
- [ ] Medium shadows for standard components
- [ ] Large shadows for hover/focus/floating elements
- [ ] Adapt shadow intensity for dark mode
- [ ] Consider color layering as alternative in dark mode

### Gradients
- [ ] Use for premium/interactive elements
- [ ] Create subtle top-to-bottom gradients
- [ ] Add inner shadow highlight on top edge
- [ ] Combine with standard shadows for depth
- [ ] Don't overuse (creates visual fatigue)
- [ ] Test readability of text over gradients

### General
- [ ] Maintain consistency across similar components
- [ ] Test in both light and dark modes
- [ ] Ensure sufficient contrast for accessibility
- [ ] Use CSS custom properties for maintainability
- [ ] Document specific use cases for each technique
- [ ] Preview on actual devices, not just design tools
