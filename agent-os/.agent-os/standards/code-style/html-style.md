# HTML Style Guide

## Structure Rules
- Use 4 spaces for indentation
- Place nested elements on new lines with proper indentation
- Content between tags should be on its own line when multi-line
- Use HTML5 semantic elements whenever possible

## Attribute Formatting
- Follow the project's specific Prettier configuration

## Example HTML Structure

```html
<div id="specific-name" class="container">
    <header class="flex flex-col space-y-2 md:flex-row md:space-y-0 md:space-x-4">
        <h1 class="text-primary dark:text-primary-300">
            Page Title
        </h1>
        <nav class="flex flex-col space-y-2 md:flex-row md:space-y-0 md:space-x-4">
            <a href="/" class="btn-ghost">
                Home
            </a>
            <a href="/about" class="btn-ghost">
                About
            </a>
        </nav>
    </header>
</div>
```
