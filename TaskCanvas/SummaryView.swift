import Foundation
import SwiftUI


struct SummaryView: View {
    var body: some View {
        Text("Good afternoon,\nTestuser.")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.top, 20)
        Text("Upcoming Events:")
            .padding(.top, 5)
        SunkenBoxView()
            .padding(.horizontal, 20)
        Text("Calendars:")
            .padding(.top, 20)
        VStack(alignment: .leading, spacing: 15) {
            NavigationLink(destination: PersonalCalendarView()) {
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
            NavigationLink(destination: ProfessionalCalendarView()) {
                Text("Professional")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan, Color.cyan]), startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(20)
                    )
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
            NavigationLink(destination: FamilyAndFriendsCalendarView()) {
                Text("Family & Friends")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange, Color.orange]), startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(20)
                    )
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
        }
        .padding(20)
            .navigationBarTitle("TaskCanvas", displayMode: .inline) // Adds a title to the navigation bar
    }
}

#Preview {
    SummaryView()
}
