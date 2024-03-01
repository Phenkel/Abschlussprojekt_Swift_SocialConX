import SwiftUI

struct LoginAndRegisterView: View {
    
    @State private var isLogin = false
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var alias = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage()
                
                VStack(spacing: 16) {
                    Image("app-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 32)
                    
                    Picker(selection: $isLogin.animation(), label: Text("Login/Register")) {
                        Text("Login_Key").tag(true)
                        Text("Register_Key").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Group {
                        HStack {
                            Image(systemName: "envelope.fill")
                            TextField("Email_Key", text: $email)
                                .keyboardType(.emailAddress)
                        }
                        HStack {
                            Image(systemName: "eye.slash.fill")
                            SecureField("Password_Key", text: $password)
                        }
                        if !isLogin {
                            HStack {
                                Image(systemName: "eye.slash.fill")
                                SecureField("PasswordConfirm_Key", text: $passwordConfirm)
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
                            Text(isLogin ? "Login_Key" : "Register_Key")
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
}

#Preview {
    LoginAndRegisterView()
}
