# TypeScript/JavaScript Style Guide

## TypeScript Preferences
- Use TypeScript for all new projects
- Enable strict mode in tsconfig.json
- Explicitly type function parameters and return types
- Use `interface` for object contracts, `type` for unions and primitives
- Prefer `const` assertions for immutable data

## Modern JavaScript Standards
- Use ES6+ features (arrow functions, destructuring, async/await)
- Prefer `const` over `let`, avoid `var`
- Use template literals for string interpolation
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Use array methods (map, filter, reduce) over traditional loops

## Function Definitions
```typescript
// Preferred: Arrow functions for simple operations
const calculateTotal = (items: Item[]): number => {
    return items.reduce((sum, item) => sum + item.price, 0)
}

// Use function declarations for complex logic
function processUserData(userData: RawUserData): User {
    // Complex processing logic here
    return processedUser
}

// Async functions
async function fetchUserData(id: number): Promise<User | null> {
    const [error, data] = await userService.getUser(id)
    return error ? null : data
}
```

## Error Handling Patterns
```typescript
// Tuple pattern for service responses
type BaseResponse<T> = [string | null, T]

// Service methods return tuples
async function getUser(id: number): Promise<BaseResponse<User>> {
    try {
        const response = await api.get(`/users/${id}`)
        return [null, response.data]
    } catch (error) {
        return [extractMessageFromError(error), null]
    }
}

// Manager classes consume services
class UserManager {
    async loadUser(id: number): Promise<User | null> {
        const [error, user] = await userService.getUser(id)
        if (error) {
            this.handleError(error)
            return null
        }
        return user
    }
}
```

## Import/Export Patterns
```typescript
// External imports first
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

// Internal imports with path aliases
import { UserManager } from '@/managers/UserManager'
import { validateEmail } from '@/utils/validation'
import type { User, UserRole } from '@core/types'

// Prefer named exports
export { UserManager, UserService }
export type { User, UserRole, UserPermissions }
```

## Object and Array Handling
```typescript
// Use destructuring with types
interface ApiResponse {
    data: User[]
    meta: { total: number }
}

const { data: users, meta } = await fetchUsers()

// Spread operator for immutable updates
const updatedUser = { ...user, email: newEmail }
const updatedUsers = [...users, newUser]

// Array methods with proper typing
const activeUsers = users.filter((user): user is ActiveUser => user.status === 'active')
const userNames = users.map(user => user.name)
```

## Class Patterns
```typescript
// Manager classes for business logic
export class OrderManager {
    private orderService: OrderService
    private notificationService: NotificationService

    constructor(
        orderService: OrderService,
        notificationService: NotificationService
    ) {
        this.orderService = orderService
        this.notificationService = notificationService
    }

    async createOrder(orderData: CreateOrderRequest): Promise<Order | null> {
        const [error, order] = await this.orderService.create(orderData)

        if (error) {
            this.handleOrderError(error)
            return null
        }

        await this.notificationService.sendOrderConfirmation(order)
        return order
    }

    private handleOrderError(error: string): void {
        console.error('Order creation failed:', error)
        // Additional error handling logic
    }
}
```

## Composables Pattern
```typescript
// Composables for reusable Vue logic
export function useFormField<T>(config: FormFieldConfig<T>) {
    const value = ref<T>(config.defaultValue)
    const error = ref<string | null>(null)
    const touched = ref(false)

    const validate = (): boolean => {
        if (!config.validators) return true

        for (const validator of config.validators) {
            const result = validator(value.value)
            if (result !== true) {
                error.value = result
                return false
            }
        }

        error.value = null
        return true
    }

    const handleBlur = (): void => {
        touched.value = true
        validate()
    }

    return {
        value: readonly(value),
        error: readonly(error),
        touched: readonly(touched),
        validate,
        handleBlur,
        setValue: (newValue: T) => { value.value = newValue }
    }
}
```