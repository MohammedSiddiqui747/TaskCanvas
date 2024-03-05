import Foundation
import SwiftUI

struct PersonalCalendarView: View {
    var body: some View {
        NavigationLink(destination: SummaryView()) {
                Text("Personal")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(20)
                    )
                    .cornerRadius(20)
                    .shadow(radius: 10)
        }
            .padding(.horizontal, 20)
        CalendarView()
            .padding(.horizontal, 20)
        SunkenBoxView()
            .padding(.horizontal, 20)
        NavigationLink(destination: AddItemView()) {
                Text("Add Item")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(20)
                    .shadow(radius: 10)
        }
            .padding(20)
            .navigationBarTitle("Personal Canvas", displayMode: .inline) // Adds a title to the navigation bar
    }
}

#Preview {
    PersonalCalendarView()
}
