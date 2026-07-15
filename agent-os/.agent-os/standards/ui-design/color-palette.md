# UI Color Palette Standards

## Context

Guidelines for creating comprehensive, scientifically-grounded UI color systems for Agent OS projects.

## UI Color Palette Structure

A complete UI color palette consists of four main categories:

### 1. Primary Color (10% of interface)

**Purpose:**
- The most prominent brand color
- NOT the most-used color (neutrals are), but the most prominent accent

**Usage:**
- CTAs and primary buttons
- Progress bars and loading indicators
- Selection controls (checkboxes, radio buttons, toggles)
- Sliders and range inputs
- Active navigation elements
- Links and interactive text

**Guidelines:**
- Typically 1-2 colors maximum
- Create 8-10 shade variations (from very light to very dark)
- Ensure sufficient contrast ratios for accessibility (WCAG AA: 4.5:1 for text)

**Example Shades:**
```css
--primary-50: #e3f2fd;   /* Lightest - backgrounds */
--primary-100: #bbdefb;  /* Very light - hover states */
--primary-200: #90caf9;  /* Light - disabled states */
--primary-300: #64b5f6;  /* Light-medium */
--primary-400: #42a5f5;  /* Medium-light */
--primary-500: #2196f3;  /* Base color - main usage */
--primary-600: #1e88e5;  /* Medium-dark - hover */
--primary-700: #1976d2;  /* Dark - pressed states */
--primary-800: #1565c0;  /* Darker */
--primary-900: #0d47a1;  /* Darkest - text */
```

### 2. Secondary/Accent Colors (Part of 30%)

**Purpose:**
- Harmonious colors derived from color wheel relationships
- Add visual variety without competing with primary color

**Color Harmony Methods:**
- **Analogous:** Colors adjacent on color wheel (e.g., blue + blue-green + green)
- **Complementary:** Opposite colors (e.g., blue + orange)
- **Split-Complementary:** Base + two colors adjacent to complement
- **Triadic:** Three colors evenly spaced on wheel
- **Monochromatic:** Different shades of same hue

**Usage:**
- Highlighting new features or announcements
- Secondary actions and buttons
- Visual variety in data visualization
- Supporting UI elements

**Guidelines:**
- Create 8-10 shade variations for each secondary color
- Maintain harmony with primary color
- Test contrast ratios for accessibility

### 3. Neutral Colors (60% of interface)

**Purpose:**
- Foundation of most UI elements
- Provides structure and readability

**Color Range:**
- Whites, grays, blacks in 8-10 shades
- Include warm or cool undertones to match brand

**Usage:**
- Body text, headings, captions, labels
- Backgrounds (page, panels, cards)
- Form controls and inputs
- Borders and dividers
- Disabled states

**Example Neutral Scale:**
```css
--neutral-0: #ffffff;    /* Pure white - backgrounds */
--neutral-50: #fafafa;   /* Off-white - subtle backgrounds */
--neutral-100: #f5f5f5;  /* Very light gray - hover states */
--neutral-200: #eeeeee;  /* Light gray - borders */
--neutral-300: #e0e0e0;  /* Medium-light gray */
--neutral-400: #bdbdbd;  /* Medium gray - disabled text */
--neutral-500: #9e9e9e;  /* Mid gray - placeholders */
--neutral-600: #757575;  /* Medium-dark gray - secondary text */
--neutral-700: #616161;  /* Dark gray - body text */
--neutral-800: #424242;  /* Darker gray - headings */
--neutral-900: #212121;  /* Very dark gray - emphasis text */
--neutral-1000: #000000; /* Pure black - rare use */
```

**Text Color Shades (Define Early):**
```css
--text-heading: var(--neutral-900);   /* Darkest for headings */
--text-body: var(--neutral-700);      /* Standard body text */
--text-caption: var(--neutral-600);   /* Lighter for captions */
--text-disabled: var(--neutral-400);  /* Disabled text */
--text-placeholder: var(--neutral-500); /* Form placeholders */
```

### 4. Semantic Colors (Status Communication)

**Purpose:**
- Communicate system states and feedback
- Provide consistent user expectations

**Color Categories:**

**Success (Green):**
- Confirmations and completed actions
- Positive feedback
- "Success" messages
```css
--success-500: #22c55e;  /* Base green */
--success-700: #15803d;  /* Dark green for text */
```

**Warning (Yellow/Amber):**
- Caution states
- Warnings that don't block actions
- "Warning" messages
```css
--warning-500: #f59e0b;  /* Base amber */
--warning-700: #b45309;  /* Dark amber for text */
```

**Info (Blue):**
- Informational messages
- Neutral notifications
- Helper text
```css
--info-500: #3b82f6;    /* Base blue */
--info-700: #1d4ed8;    /* Dark blue for text */
```

**Error/Danger (Red/Orange):**
- Error messages
- Destructive actions
- Failed attempts
- **Exception:** If red is your primary color, use orange instead
```css
--error-500: #ef4444;   /* Base red */
--error-700: #b91c1c;   /* Dark red for text */
```

**Guidelines for Semantic Colors:**
- Create 8-10 shades for each semantic color
- Ensure dark shades meet contrast requirements for text
- Light shades work well for backgrounds (alerts, badges)

## The 60-30-10 Rule

**Visual Balance Formula:**
- **60%** Dominant (neutral colors)
- **30%** Secondary (supporting colors including secondary/accent)
- **10%** Accent (primary color for emphasis)

**Application:**
```
Page background: Neutral (60%)
├── Card/Panel: Neutral (60%)
│   ├── Body text: Neutral (60%)
│   ├── Borders: Neutral (60%)
│   └── Icons: Secondary (30%)
└── Button: Primary (10%)
    └── CTA text: Neutral
```

## Implementation Guidelines

### Creating Shade Variations

**Tools:**
- **Colorbox by Lyft:** Automated shade generation with accessibility checks
- **Adobe Color Wheel:** Finding harmonious color relationships
- **Coolors.co:** Quick palette generation and testing
- **Contrast Checker (WebAIM):** WCAG compliance verification

**Manual Approach:**
1. Start with base color (500 shade)
2. Lighten for 50-400 (increase lightness by 8-12% per step)
3. Darken for 600-900 (decrease lightness by 8-12% per step)
4. Adjust saturation slightly (reduce in lighter/darker extremes)
5. Test contrast ratios for text usage

### Accessibility Requirements

**WCAG 2.1 Contrast Ratios:**
- **AA (Minimum):** 4.5:1 for normal text, 3:1 for large text (18pt+)
- **AAA (Enhanced):** 7:1 for normal text, 4.5:1 for large text

**Best Practices:**
- Use 700+ shades for text on light backgrounds
- Use 100-300 shades for text on dark backgrounds
- Test all color combinations used for text
- Provide non-color indicators for critical information

### CSS Implementation

**Define as CSS Custom Properties:**
```css
:root {
    /* Primary Colors */
    --primary-50: #e3f2fd;
    --primary-500: #2196f3;
    --primary-900: #0d47a1;
    
    /* Neutral Colors */
    --neutral-0: #ffffff;
    --neutral-500: #9e9e9e;
    --neutral-900: #212121;
    
    /* Semantic Colors */
    --success-500: #22c55e;
    --error-500: #ef4444;
    --warning-500: #f59e0b;
    --info-500: #3b82f6;
    
    /* Functional Tokens */
    --color-text-primary: var(--neutral-900);
    --color-text-secondary: var(--neutral-700);
    --color-bg-primary: var(--neutral-0);
    --color-bg-secondary: var(--neutral-50);
    --color-border: var(--neutral-200);
}

@media (prefers-color-scheme: dark) {
    :root {
        --color-text-primary: var(--neutral-100);
        --color-text-secondary: var(--neutral-300);
        --color-bg-primary: var(--neutral-900);
        --color-bg-secondary: var(--neutral-800);
        --color-border: var(--neutral-700);
    }
}
```

## Practical Component Examples

### Button States
```css
.button-primary {
    background: var(--primary-500);
    color: var(--neutral-0);
    
    &:hover {
        background: var(--primary-600);
    }
    
    &:active {
        background: var(--primary-700);
    }
    
    &:disabled {
        background: var(--primary-200);
        color: var(--neutral-400);
    }
}
```

### Form Elements
```css
.input {
    background: var(--neutral-0);
    border: 1px solid var(--neutral-300);
    color: var(--neutral-900);
    
    &::placeholder {
        color: var(--neutral-500);
    }
    
    &:focus {
        border-color: var(--primary-500);
        box-shadow: 0 0 0 3px var(--primary-100);
    }
    
    &.error {
        border-color: var(--error-500);
        
        &:focus {
            box-shadow: 0 0 0 3px var(--error-100);
        }
    }
}
```

### Alert Components
```css
.alert-success {
    background: var(--success-50);
    border-left: 4px solid var(--success-500);
    color: var(--success-900);
}

.alert-error {
    background: var(--error-50);
    border-left: 4px solid var(--error-500);
    color: var(--error-900);
}
```

### Navigation
```css
.nav-link {
    color: var(--neutral-700);
    
    &:hover {
        color: var(--neutral-900);
        background: var(--neutral-100);
    }
    
    &.active {
        color: var(--primary-500);
        background: var(--primary-50);
        border-left: 3px solid var(--primary-500);
    }
}
```

## Color Psychology & Selection

**Impact:**
- Color choices influence 62-90% of subconscious product judgments
- Consistency builds trust and brand recognition
- Different industries have color expectations

**Common Associations:**
- **Blue:** Trust, stability, professionalism (finance, tech, healthcare)
- **Green:** Growth, health, eco-friendly (wellness, environment, finance)
- **Red:** Energy, urgency, passion (food, entertainment, sales)
- **Purple:** Luxury, creativity, wisdom (beauty, education, creative)
- **Orange:** Friendly, energetic, affordable (retail, food, children)
- **Yellow:** Optimism, clarity, warmth (travel, children, food)

## Extension for Data Visualization

For dashboards, charts, and data-heavy interfaces:

**Create Additional Categorical Colors:**
- 6-8 distinct colors for different data categories
- Ensure they're distinguishable for colorblind users
- Test with colorblind simulators
- Provide patterns or icons as secondary indicators

**Example Categorical Palette:**
```css
--data-1: #2196f3;  /* Blue */
--data-2: #4caf50;  /* Green */
--data-3: #ff9800;  /* Orange */
--data-4: #9c27b0;  /* Purple */
--data-5: #f44336;  /* Red */
--data-6: #00bcd4;  /* Cyan */
--data-7: #ffeb3b;  /* Yellow */
--data-8: #795548;  /* Brown */
```

## Common Pitfalls to Avoid

1. **Too Many Primary Colors:** Stick to 1-2 maximum
2. **Insufficient Contrast:** Always test against WCAG standards
3. **Neglecting Dark Mode:** Plan for both light and dark themes
4. **Inconsistent Application:** Document where each color is used
5. **Skipping Neutral Variations:** These comprise 60% of your interface
6. **Using Pure Black (#000):** Often too harsh; use very dark gray instead
7. **Color-Only Communication:** Always provide additional indicators

## Summary Checklist

- [ ] Define primary color with 8-10 shades
- [ ] Create secondary/accent colors using color harmony
- [ ] Establish neutral scale (8-10 shades) with text color definitions
- [ ] Set semantic colors (success, warning, info, error)
- [ ] Test all text/background combinations for contrast
- [ ] Apply 60-30-10 rule for visual balance
- [ ] Create functional tokens (--color-text-primary, etc.)
- [ ] Plan for dark mode variants
- [ ] Document specific use cases for each color
- [ ] Extend palette for data visualization if needed
