#  Modren Concurrency 

## Problem 
The Pyramid of Doom occurs when multiple asynchronous operations are nested within each other, making the code unreadable and difficult to manage.

        func fetchUser(completion: @escaping (User?) -> Void) {
            URLSession.shared.dataTask(with: URL(string: "https://api.example.com/user")!) { data, _, _ in
                guard let data = data else {
                    completion(nil)
                    return
                }
                let user = try? JSONDecoder().decode(User.self, from: data)
                completion(user)
            }.resume()
        }

        func fetchPosts(for userId: Int, completion: @escaping ([Post]?) -> Void) {
            URLSession.shared.dataTask(with: URL(string: "https://api.example.com/posts?userId=\(userId)")!) { data, _, _ in
                guard let data = data else {
                    completion(nil)
                    return
                }
                let posts = try? JSONDecoder().decode([Post].self, from: data)
                completion(posts)
            }.resume()
        }

        func fetchComments(for postId: Int, completion: @escaping ([Comment]?) -> Void) {
            URLSession.shared.dataTask(with: URL(string: "https://api.example.com/comments?postId=\(postId)")!) { data, _, _ in
                guard let data = data else {
                    completion(nil)
                    return
                }
                let comments = try? JSONDecoder().decode([Comment].self, from: data)
                completion(comments)
            }.resume()
        }

        // Pyramid of Doom - Nested Callbacks
        fetchUser { user in
            guard let user = user else { return }
            
            fetchPosts(for: user.id) { posts in
                guard let posts = posts else { return }
                
                fetchComments(for: posts.first!.id) { comments in
                    guard let comments = comments else { return }
                    
                    print("User: \(user), Posts: \(posts), Comments: \(comments)")
                }
            }
        }


//MAKR: -

## Async await solution 

        func fetchUser() async throws -> User {
            let url = URL(string: "https://api.example.com/user")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(User.self, from: data)
        }

        func fetchPosts(for userId: Int) async throws -> [Post] {
            let url = URL(string: "https://api.example.com/posts?userId=\(userId)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Post].self, from: data)
        }

        func fetchComments(for postId: Int) async throws -> [Comment] {
            let url = URL(string: "https://api.example.com/comments?postId=\(postId)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Comment].self, from: data)
        }

        // ✅ Clean, Readable, and Maintainable
        Task {
            do {
                let user = try await fetchUser()
                let posts = try await fetchPosts(for: user.id)
                let comments = try await fetchComments(for: posts.first!.id)
                
                print("User: \(user), Posts: \(posts), Comments: \(comments)")
            } catch {
                print("Error: \(error)")
            }
        }

NOTE: - Thread that is used by async call is not blocked


### await - Sequential Execution
When you use await, each asynchronous function waits for the previous one to finish before proceeding.

          func fetchUser() async throws -> User { /* API Call */ }
          func fetchPosts(for userId: Int) async throws -> [Post] { /* API Call */ }
          func fetchComments(for postId: Int) async throws -> [Comment] { /* API Call */ }
          
          Task {
              do {
                  let user = try await fetchUser() // Waits for user to be fetched
                  let posts = try await fetchPosts(for: user.id) // Waits for posts after user
                  let comments = try await fetchComments(for: posts.first!.id) // Waits for comments after posts
          
        print("User: \(user), Posts: \(posts), Comments: \(comments)")
      } catch {
          print("Error: \(error)")
      }
  }

### async let - Parallel Execution
async let allows multiple asynchronous tasks to start at the same time and await their results later, improving performance.


          Task {
              do {
                  async let user = fetchUser() // Starts fetching user
                  async let posts = fetchPosts(for: await user.id) // Starts fetching posts as soon as user is available
                  async let comments = fetchComments(for: await posts.first!.id) // Starts fetching comments as soon as posts are available
  
          // Wait for all tasks to complete
          let (fetchedUser, fetchedPosts, fetchedComments) = try await (user, posts, comments)
          
          print("User: \(fetchedUser), Posts: \(fetchedPosts), Comments: \(fetchedComments)")
      } catch {
          print("Error: \(error)")
      }
    }

### Task and TaskGroup

Regular Task (Unstructured Concurrency)
  Runs asynchronous code inside an existing context.
  Useful for launching independent background work.

    Task {
        print("Task started on thread: \(Thread.current)")
        let result = await fetchData()
        print("Fetched data: \(result)")
    }
### TaskGroup
  A TaskGroup allows you to create multiple concurrent tasks and wait for all of them to complete.

  Why Use TaskGroup?
  Runs multiple async tasks concurrently.
  Automatically waits for all tasks to finish before proceeding.
  Can dynamically add tasks at runtime.

    func fetchAllData() async {
      await withTaskGroup(of: String.self) { group in
          group.addTask { await fetchData(from: "API 1") }
          group.addTask { await fetchData(from: "API 2") }
          group.addTask { await fetchData(from: "API 3") }
  
          for await result in group {
              print("Received: \(result)")
          }
      }
    }

### Task Cancellation

          let task = Task {
              for i in 1...10 {
                  if Task.isCancelled {
                      print("Task was cancelled. Exiting...")
                      return
                  }
                  print("Processing item \(i)")
                  try? await Task.sleep(nanoseconds: 500_000_000) // Simulate work (0.5s)
              }
              print("Task completed successfully")
          }
          
          // Cancel after 1 second
          Task {
              try? await Task.sleep(nanoseconds: 1_000_000_000) // 1s delay
              task.cancel() // Cancels the running task
          }


### Actors 

Why Do We Need Actors?
In a multi-threaded environment, a shared mutable state can cause race conditions and unexpected behaviors. Before Swift concurrency, we used:

- Locks (DispatchQueue.sync) → Can cause deadlocks.
- Serial Queues → Adds complexity to code.
- Actors solve this by ensuring only one task accesses a mutable state at a time.

          actor BankAccount {
              private var balance: Int = 0
  
              func deposit(amount: Int) {
                  balance += amount
              }
          
              func getBalance() -> Int {
                  return balance
              }
          }
