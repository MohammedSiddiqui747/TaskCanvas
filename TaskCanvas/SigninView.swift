import SwiftUI
import FirebaseAuth

struct SigninView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isAuthenticated: Bool = false  // State to manage authentication status

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Email")
                    .fontWeight(.semibold)
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress) // Specific keyboard for email input
                    .autocapitalization(.none) // Disable capitalization
                
                Text("Password")
                    .fontWeight(.semibold)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }
                
                Button("Sign in") {
                    signInUser()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                
                NavigationLink("Create Account", destination: SignupView())
                    .padding(.top, 20)
                
                // Navigation Link that activates on successful login
                NavigationLink("", destination: SummaryView(), isActive: $isAuthenticated)
            }
            .padding(50)
            .navigationBarTitle("Sign in", displayMode: .inline)
        }
    }

    private func signInUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = nil
                self.isAuthenticated = true  // Set isAuthenticated to true to navigate
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
