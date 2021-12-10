//
//  LogInView.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import SwiftUI

struct LogInView: View {
    
    @State var email = ""
    @State var password = ""
    //    @State var isLogged = false
    //    @State var shouldRegistrate = false
    
    @ObservedObject var loginVM = LogInVM()
    @ObservedObject var bookVM = BookVM()
    @ObservedObject var recVM = RecommendedVM()
    @ObservedObject var detailVM = DetailBookVM()
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Email", text: $email)
                    .frame(width: 250, height: 30, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.purple, lineWidth: 4)
                    ).autocapitalization(.none)
                    .multilineTextAlignment(.center)
                
                SecureField("Password", text: $password)
                    .frame(width: 250, height: 30, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.purple, lineWidth: 4)
                    )
                    .multilineTextAlignment(.center)
                
                HStack{
                    NavigationLink(destination: BookTabView(bookVM: bookVM, recVM: recVM, detailVM: detailVM), isActive: $loginVM.isLogged) {
                        Button {
                            loginVM.logIn(email: email, password: password)
                        } label: {
                            Text("Login")
                        }
                        .alert("Not a proper Email", isPresented: $loginVM.shouldAlertEmail) {
                                    Button("OK", role: .cancel) { }
                                }
                        .alert("Wrong credentials", isPresented: $loginVM.shouldAlertCredentials) {
                                    Button("OK", role: .cancel) { }
                                }
                        .frame(width: 100, height: 30, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.purple, lineWidth: 4)
                        )
                        .foregroundColor(.purple)
                    }
                    
                    NavigationLink(destination: RegistrationView(loginVM: loginVM), isActive: $loginVM.shouldRegistrate) {
                        Button {
                            loginVM.shouldRegistrate = true
                        } label: {
                            Text("Registration")
                        }
                        .frame(width: 100, height: 30, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.purple, lineWidth: 4)
                        )
                        .foregroundColor(.purple)
                    }
                    
                }
                .padding(.top, 20)
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
