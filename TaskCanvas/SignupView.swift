import SwiftUI
import Firebase

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var showingSuccessAlert = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Confirm your password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }

                Button("Sign up") {
                    handleSignup()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .padding(.top, 20)
            }
            .padding()
            .navigationBarTitle("Sign Up", displayMode: .inline)
            .alert(isPresented: $showingSuccessAlert) {
                Alert(title: Text("Signup Successful"), message: Text("You have successfully signed up. Please log in."), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func handleSignup() {
        guard email.isEmpty == false, password.isEmpty == false else {
            errorMessage = "Email and password must not be empty"
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            } else {
                DispatchQueue.main.async {
                    self.email = ""
                    self.password = ""
                    self.confirmPassword = ""
                    self.errorMessage = nil
                    self.showingSuccessAlert = true
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
