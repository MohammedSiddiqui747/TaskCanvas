import Foundation
import SwiftUI

struct SigninView: View {
    // State variables to store the username and password
    @State private var username: String = "MockUser" // Pre-input mock data for username
    @State private var password: String = "MockPassword" // Pre-input mock data for password

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Username")
                .fontWeight(.semibold)
            
            // Username TextField
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Password")
                .fontWeight(.semibold)
            
            // Password SecureField
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            
            // Add buttons or additional fields as needed
            NavigationLink(destination: SummaryView()) {
                Text("Sign in")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        }
        .padding(50)
        .navigationBarTitle("Sign in", displayMode: .inline) // Adds a title to the navigation bar
        
    }
}

#Preview {
    SigninView()
}
