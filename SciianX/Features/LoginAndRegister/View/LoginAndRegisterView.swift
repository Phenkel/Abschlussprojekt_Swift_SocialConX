import SwiftUI
import UIKit

struct LoginAndRegisterView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var isLogin = false
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var alias = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                Image("app-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 32)
                
                Picker(selection: $isLogin.animation(), label: Text("Login/Register")) {
                    Text("Login").tag(true)
                    Text("Create User").tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                
                Group {
                    HStack {
                        Image(systemName: "envelope.fill")
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    HStack {
                        Image(systemName: "eye.slash.fill")
                        SecureField("Password", text: $password)
                    }
                    if !isLogin {
                        HStack {
                            Image(systemName: "eye.slash.fill")
                            SecureField("Confirm Password", text: $passwordConfirm)
                        }
                    }
                }
                .padding(12)
                .background(.bar)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    // Button Action
                }, label: {
                    HStack {
                        Spacer()
                        Text(isLogin ? "Login" : "Create User")
                            .foregroundStyle(.white)
                            .padding(8)
                        Spacer()
                    }
                })
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
    }
}

#Preview {
    LoginAndRegisterView()
}
