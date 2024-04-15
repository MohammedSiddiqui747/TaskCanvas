import Foundation
import SwiftUI



struct AddItemView: View {
    @State private var selectedDate = Date()
    
    @State private var taskName: String = "Some Calendar Event" // Pre-input mock data for username
    @State private var taskDesc: String = "A description and/or additional information about the calendar item." // Pre-input mock data for password
    
    @State private var selectedSegment = 0
    let options = ["Event", "Routine", "Task"]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    private var dbHelper = FireDBHelper.getInstance()
    

    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Enter Calendar Item Info")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Text("Item Name: ")
            TextField("ItemName", text: $taskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
        
            Text("Item Type: ")
            Picker("Options", selection: $selectedSegment) {
                ForEach(0..<3) { index in
                    Text(self.options[index]).tag(index)
                }
            }
                .padding(.bottom, 20)
                .pickerStyle(SegmentedPickerStyle())
            
            DatePicker("Date & Time:", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .padding(.bottom, 20)
            
            Text("Description: ")
            TextEditor(text: $taskDesc)
                .frame(height: 100)
            
            Spacer()
            
            Button("Add Item") {
                if taskName.isEmpty || taskDesc.isEmpty {
                    alertMessage = "Please fill in all fields."
                    showAlert = true
                } else {
                    let formattedDate = selectedDate.formatted(.iso8601.year().month().day())
                    
                    let newTask = Task(taskname: taskName, taskdesc: taskDesc, tasktype: options[selectedSegment], caltype: "", taskdate: formattedDate, useremail: "") // Consider including the destination in your item model
                    dbHelper.insertTask(task: newTask)
                    alertMessage = "Task added successfully."
                    showAlert = true
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(20)
            .shadow(radius: 10)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("This will take you back."),
                    primaryButton: .default(Text("Confirm")) {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding(30)
        .navigationBarTitle("Add Calendar Item", displayMode: .inline) // Adds a title to the navigation bar
    }
}

#Preview {
    AddItemView()
}
