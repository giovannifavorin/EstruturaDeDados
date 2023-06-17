import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var completed: Bool
}

class TodoStore: ObservableObject {
    @Published var todos: [TodoItem] = []
    
    // Create
    func addTodo(title: String) {
        let todo = TodoItem(title: title, completed: false)
        todos.append(todo)
    }
    
    // Read
    func getTodoById(id: UUID) -> TodoItem? {
        return todos.first(where: { $0.id == id })
    }
    
    // Update
    func updateTodoTitle(id: UUID, newTitle: String) {
        if let todoIndex = todos.firstIndex(where: { $0.id == id }) {
            todos[todoIndex].title = newTitle
        }
    }
    
    func toggleTodoCompletion(id: UUID) {
        if let todoIndex = todos.firstIndex(where: { $0.id == id }) {
            todos[todoIndex].completed.toggle()
        }
    }
    
    // Delete
    func deleteTodo(id: UUID) {
        todos.removeAll(where: { $0.id == id })
    }
}

struct TodoListView: View {
    @ObservedObject var todoStore = TodoStore()
    @State private var newTodoTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(todoStore.todos) { todo in
                    HStack {
                        Text(todo.title)
                        Spacer()
                        Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                    }
                    .onTapGesture {
                        todoStore.toggleTodoCompletion(id: todo.id)
                    }
                }
                .navigationBarTitle("Todos")
                
                HStack {
                    TextField("New Todo", text: $newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        todoStore.addTodo(title: newTodoTitle)
                        newTodoTitle = ""
                    }) {
                        Text("Add")
                    }
                }
                .padding()
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        TodoListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
