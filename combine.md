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
