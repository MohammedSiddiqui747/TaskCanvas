import Foundation
import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let time: String
}

struct SunkenBoxView: View {
    let events = [
        Event(title: "Event 1", description: "Description of Event 1", time: "10:00 AM"),
        Event(title: "Event 2", description: "Description of Event 2", time: "12:00 PM"),
        // Add more events as needed
    ]

    var body: some View {
        ZStack {
            // Background to achieve the sunken effect
            Color.gray.opacity(0.2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(color: .white, radius: 8, x: -8, y: -8)
                .shadow(color: .white, radius: 8, x: 8, y: 8)
                .edgesIgnoringSafeArea(.all)
            
            // Scrollable list of events
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(events) { event in
                        HStack(spacing: 10) {
                            Text(event.title)
                                .fontWeight(.bold)
                            Text(event.description)
                            Text(event.time)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .cornerRadius(20)
    }
}
#Preview {
    SunkenBoxView()
}
