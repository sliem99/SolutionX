# Reactive Programming

Reactive programming is a declarative paradigm focused on data streams and the propagation of change. Instead of writing code that imperatively tells the computer *how* to perform tasks step-by-step, reactive programming lets you declare *what* should happen when data changes or events occur.

## Key Concepts

- **Data Streams:**  
  Every piece of data (such as user inputs, network responses, or sensor readings) is treated as a continuous stream of events. These streams can emit:
  - **Next:** Data values
  - **Error:** Failure events
  - **Complete:** A signal that no further data will be emitted

- **Observers and Subscriptions:**  
  Components subscribe to these data streams to get notified whenever a new event occurs. This allows the application to react immediately to changes.

- **Operators:**  
  A rich set of functions (like `map`, `filter`, `reduce`, and `flatMap`) is provided to transform, combine, or filter data streams. This composability helps build complex asynchronous pipelines with minimal code.

- **Asynchrony and Non-blocking Behavior:**  
  Reactive programming is inherently asynchronous. Data is processed as it becomes available, which improves responsiveness and resource utilization without blocking the main execution thread.
  # Combine 
- **What is Combine?**  
  A reactive programming framework from Apple that simplifies asynchronous programming by using publishers to emit values over time and subscribers to react to these values.
  
- **Why Use Combine?**  
  - Cleaner, more maintainable code.
  - Seamless integration with SwiftUI.
  - Simplified error handling and cancellation.

---

## 2. Core Components of Combine

### A. Publishers

**Definition:**  
A publisher is an entity that emits values (or events) over time. Every publisher has an associated output type and a failure type.

**Common Publishers:**
- **Just:** Emits a single value and then completes.
- **Future:** Emits a value asynchronously in the future.

**Example: Using a `Just` Publisher**

```swift
import Combine

// Create a publisher that emits the integer 5.
let numberPublisher = Just(5)

// Subscribe and print the emitted value.
let subscription = numberPublisher
    .sink(receiveCompletion: { completion in
        print("Completed: \(completion)")
    }, receiveValue: { value in
        print("Received value: \(value)") // Expected output: 5
    })
```

### B. Subscribers
Definition:
Subscribers listen to publishers and react to the emitted values. The most common subscriber is the sink operator, which allows you to specify closures to handle values and completions.

Key Considerations:

 - Always retain your subscription (commonly using an AnyCancellable set) to keep the subscription alive.

### C. Subjects
Definition:
Subjects are special types of publishers that can also receive values, making them a bridge between imperative and reactive code.

Types of Subjects:

#### 1- PassthroughSubject

Does not store values. It passes along events to subscribers as they occur.

```swift
import Combine

let passthrough = PassthroughSubject<String, Never>()

// Subscribe to the subject.
let passthroughSubscription = passthrough.sink { value in
    print("PassthroughSubject received: \(value)")
}

// Manually send a value.
passthrough.send("Hello from PassthroughSubject")
```

#### 2- CurrentValueSubject

Characteristics:
Holds a current value that is immediately sent to new subscribers.

```swift
import Combine

let currentValue = CurrentValueSubject<String, Never>("Initial Value")

// Subscribe to the subject.
let currentValueSubscription = currentValue.sink { value in
    print("CurrentValueSubject received: \(value)")
}

// Update the value; subscribers will receive the new value.
currentValue.send("Updated Value")
```

### Key Differences Between Subjects and Publishers

### 1- Emission Control
####  **Publishers:**  
  - Emit values based on their internal logic and configuration.
  - You cannot manually push values into a publisher after it's created.
####  **Subjects:**  
  - Allow you to imperatively send values using the `send(_:)` method.
  - Act as both a publisher and a subscriber, letting you control when values are emitted.

### 2- Cold vs. Hot Behavior
#### **Publishers:**  
  - Typically "cold" – they don’t start emitting values until a subscriber attaches.
#### **Subjects:**  
  - Are "hot" – they immediately emit values when `send(_:)` is called, regardless of whether a subscriber is present.

### 3- State Management
#### **Publishers:**  
  - Generally stateless; they produce values without retaining previous ones (unless combined with stateful operators).
#### **Subjects:**  
  - Can be stateful. For example, `CurrentValueSubject` retains the most recent value and immediately provides it to new subscribers, while `PassthroughSubject` does not.

### 4- Usage Scenarios
#### **Publishers:**  
  - Best suited for modeling asynchronous operations such as network requests, timers, or file I/O.
#### **Subjects:**  
  - Ideal for bridging imperative event sources (like UI events or notifications) into reactive streams where you need explicit control over value emission.


## 3. Operators in Combine
Operators transform, filter, combine, or otherwise manipulate the data flowing through a pipeline. Some key operators include:

- Mapping: map, flatMap
- Filtering: filter, compactMap
- Combining: merge, zip, combineLatest
- Error Handling: catch, retry
- Debugging: print()

```swift
import Combine

let numbersPublisher = [1, 2, 3, 4, 5].publisher

let chainedSubscription = numbersPublisher
    .filter { $0 % 2 == 0 }   // Keep only even numbers.
    .map { $0 * 3 }           // Multiply each by 3.
    .sink { value in
        print("Processed value: \(value)")
    }
// Expected outputs: 6 and 12.
```


## 4- The Assign Operator
Purpose:
The assign operator binds a publisher’s output directly to a property of an object. This is particularly useful for updating UI elements or view model properties without writing extra closure code.

```swift 
import Combine
import Foundation

class UserViewModel: ObservableObject {
    @Published var username: String = ""
}

let viewModel = UserViewModel()

let usernameSubject = CurrentValueSubject<String, Never>("InitialUser")

// Bind the subject’s output to the view model's username property.
let cancellableSubject = usernameSubject.assign(to: \.username, on: viewModel)

print("Username: \(viewModel.username)") // Output: "InitialUser"

// Sending a new value updates the property automatically.
usernameSubject.send("UpdatedUser")
print("Username after update: \(viewModel.username)")
```


## Cancellation in Combine 
it refers to stopping an active subscription to a publisher, preventing further value emissions and resource usage.

Key Aspects of Cancellation:
- Automatic Cancellation:

When an AnyCancellable instance is deallocated, the associated subscription is automatically canceled.
Explicit Cancellation:

You can manually cancel a subscription by calling .cancel() on an AnyCancellable instance.
```swift 
let cancellable = Just(10)
    .sink { print($0) }
cancellable.cancel() // Stops receiving values
```
- Using Set<AnyCancellable>:
The standard practice is to store subscriptions in a Set<AnyCancellable>, so they are automatically canceled when their owner (e.g., a ViewModel) is deallocated.

```swift 
var cancellables = Set<AnyCancellable>()
publisher.sink { print($0) }
    .store(in: &cancellables)
```
