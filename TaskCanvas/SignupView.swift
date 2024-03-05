import Foundation
import SwiftUI

struct SignupView: View {
    // State variables to store the username and password
    @State private var username: String = "MockUser" // Pre-input mock data for username
    @State private var password: String = "MockPassword" // Pre-input mock data for password

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Username")
                .fontWeight(.semibold)
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Password")
                .fontWeight(.semibold)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            Text("Confirm Password")
                .fontWeight(.semibold)
            SecureField("Confirm Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            NavigationLink(destination: SummaryView()) {
                Text("Sign up")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
            }
        }
        .padding(50)
        .navigationBarTitle("Sign up", displayMode: .inline) // Adds a title to the navigation bar
    }
}

#Preview {
    SignupView()
}
