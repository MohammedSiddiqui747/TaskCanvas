import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("startscreen")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("TaskCanvas")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer()
                    VStack(spacing: 10) {
                        NavigationLink(destination: SigninView()) {
                            Text("Sign in")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                        NavigationLink(destination: SignupView()) {
                            Text("Sign up")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 50) // Adds horizontal padding to the buttons
                    .padding(.bottom, 20) // Adds some space at the bottom
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
