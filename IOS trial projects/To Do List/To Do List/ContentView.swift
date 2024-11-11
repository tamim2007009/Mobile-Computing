import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ToDo.isCompleted) private var toDos: [ToDo]
    
    @State private var isAlertShowing = false
    @State private var toDoTitle = ""
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(toDos) { toDo in
                    
                    HStack{
                        
                        Button {
                            toDo.isCompleted.toggle()
                        } label: {
                            Image(systemName: toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                        
                        Text(toDo.title)
                        
                    }
                }
                .onDelete(perform: deleteToDos)
            }
            .navigationTitle("To Do App")
            .toolbar {
                Button {
                    isAlertShowing.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
//            .alert(isPresented: $isAlertShowing) {
//                Alert(
//                    title: Text("New ToDo"),
//                    message: Text("Enter the title of your new ToDo"),
//                    primaryButton: .default(Text("Add")) {
//                        addNewToDo()
//                    },
//                    secondaryButton: .cancel()
//                )
//            }
            
            .alert("Add ToDo",isPresented: $isAlertShowing){
                
                TextField("Enter ToDo",text:$toDoTitle)
                
                Button {
                    modelContext.insert(ToDo(title: toDoTitle, isCompleted: false))
                    toDoTitle = ""
                } label: {
                    Text("Add")
                }
                
                
                
            }
            .overlay {
                
//                ContentUnavailableView("Nothing to do here", systemImage: "checkmark.circle.fill")
                
                if toDos.isEmpty {
                    ContentUnavailableView("Nothing to do here", systemImage: "checkmark.circle.fill")
                    
                }
                    
                    
                    
            }
        }
    }
    
    func deleteToDos(_ indexSet: IndexSet) {
        for index in indexSet {
            let toDo = toDos[index]
            modelContext.delete(toDo)
        }
    }
    
    func addNewToDo() {
        if !toDoTitle.isEmpty {
            let newToDo = ToDo(title: toDoTitle, isCompleted: false)
            modelContext.insert(newToDo)
            toDoTitle = "" // Reset the input after adding
        }
    }
}

#Preview {
    ContentView()
}



