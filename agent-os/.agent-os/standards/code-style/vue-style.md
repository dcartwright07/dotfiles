# Vue Style Guide

## Component Structure Rules
- **Script at top**: Always place `<script setup lang="ts">` at the top of .vue files
- **Template second**: Place `<template>` section after script
- **Style at bottom**: Place `<style scoped>` section at the bottom
- Use 4 spaces for indentation consistently
- Place nested elements on new lines with proper indentation
- Content between tags should be on its own line when multi-line
- Use HTML5 semantic elements whenever possible

## Vue 3 Composition API Standards
- Use `<script setup lang="ts">` syntax for all components
- Use Composition API exclusively (not Options API)
- Always include TypeScript: `<script setup lang="ts">`
- Define props with interfaces: `defineProps<Props>()`
- Define emits with interfaces: `defineEmits<Emits>()`
- Use `defineModel<T>()` for v-model implementation
- Use `useTemplateRef()` for template references

## TypeScript Integration
- Always include types for all variables and functions
- Use interfaces for Props and Emits
- Use generics for reusable component logic
- Type reactive references: `const count = ref<number>(0)`
- Type computed properties: `const doubled = computed<number>(() => count.value * 2)`

## Component Architecture
- **Composables**: Extract reusable logic to composables (useFormField, useApi, etc.)
- **Manager Classes**: Use Manager classes for complex business logic
- **Service Layer**: Use services for API integration with tuple returns [error, data]
- **Components**: Focus on presentation and user interaction only

## Styling Standards
- Use `<style scoped>` for component-specific styles
- Use nested CSS structure within scoped blocks
- Add styles to global CSS file if shared across multiple components
- Use semantic ID selectors for major component sections
- Use CSS custom properties (variables) for theming

## Attribute Formatting
- Follow the project's specific Prettier configuration

## Form Field Component Example

```vue
<script lang="ts" setup>
import { DropdownField } from '@core/forms'
import { useAttrs, useTemplateRef } from 'vue'
import Skeleton from 'primevue/skeleton'

const attrs = useAttrs()
const model = defineModel<any>({ required: true })

interface Props {
    loading?: boolean
}
const { loading = false } = defineProps<Props>()

const statusField = useTemplateRef('field')
defineExpose({ validate: () => statusField.value?.validate() })
</script>

<template>
    <div v-if="loading" class="form-field">
        <Skeleton class="mb-1" height="0.5rem" width="5rem" />
        <Skeleton height="2.5rem" />
    </div>

    <DropdownField
        ref="field"
        v-model="model"
        label="Status"
        option-label="label"
        option-value="value"
        placeholder="Select a status"
        v-bind="attrs"
    />
</template>

<style scoped>
.form-field {
    margin-bottom: 1rem;

    .mb-1 {
        margin-bottom: 0.25rem;
    }
}
</style>
```

## Mobile Component Example (Ionic Vue)

```vue
<script lang="ts" setup>
import { IonInput, IonItem, IonInputPasswordToggle } from '@ionic/vue'
import type { BaseFieldProps, BaseFieldEmits, FieldType } from '../types'
import { useFormField } from '../composables/useFormField'

interface Props extends BaseFieldProps {
    type?: FieldType
    showPasswordToggle?: boolean
}

const props = withDefaults(defineProps<Props>(), {
    type: 'text',
    required: false,
    disabled: false,
    readonly: false,
    validators: () => [],
    showPasswordToggle: false,
})

const emit = defineEmits<BaseFieldEmits>()

const { handleBlur, handleFocus, fieldError } = useFormField({ props, emit })

const handleInput = (event: CustomEvent) => {
    const value = event.detail.value || ''
    emit('update:modelValue', value)
}
</script>

<template>
    <div class="xps-field-container">
        <ion-item
            :class="{ 'xps-input-item--error': fieldError() }"
            class="xps-input-item"
        >
            <ion-input
                :disabled="props.disabled"
                :placeholder="props.placeholder"
                :readonly="props.readonly"
                :type="props.type"
                :value="props.modelValue"
                fill="outline"
                @ion-input="handleInput"
                @ion-blur="handleBlur"
                @ion-focus="handleFocus"
            >
                <ion-input-password-toggle
                    v-if="props.type === 'password' && props.showPasswordToggle"
                    slot="end"
                />
            </ion-input>
        </ion-item>
        <div v-if="fieldError()" class="xps-field-error">
            {{ fieldError() }}
        </div>
    </div>
</template>

<style scoped>
.xps-field-container {
    margin-bottom: 1rem;

    .xps-input-item {
        --background: transparent;

        &--error {
            --border-color: var(--ion-color-danger);
        }
    }

    .xps-field-error {
        color: var(--ion-color-danger);
        font-size: 0.875rem;
        margin-top: 0.25rem;
    }
}
</style>
```
