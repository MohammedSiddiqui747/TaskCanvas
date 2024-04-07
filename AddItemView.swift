import Foundation
import SwiftUI

struct AddItemView: View {
    @State private var selectedDate = Date()
    
    @State private var itemname: String = "Some Calendar Event" // Pre-input mock data for username
    @State private var password: String = "MockPassword" // Pre-input mock data for password
    @State private var description: String = "A description and/or additional information about the calendar item." // Pre-input mock data for password
    
    @State private var selectedSegment = 0
    let options = ["Event", "Routine", "Task"]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingConfirmation = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Enter Calendar Item Info")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Text("Item Name: ")
            TextField("ItemName", text: $itemname)
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
            TextEditor(text: $description)
                .frame(height: 100)
            
            Spacer()
            
            Button("Add Item") {
                showingConfirmation = true
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(20)
            .shadow(radius: 10)
            .alert(isPresented: $showingConfirmation) {
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
