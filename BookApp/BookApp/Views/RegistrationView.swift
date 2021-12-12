//
//  RegistrationView.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import SwiftUI

struct RegistrationView: View {
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var surname = ""
    @State var genre = "Espionage"
    
    let genres = ["Humor", "Health", "Fiction", "Espionage"]
    
    var loginVM : LogInVM
    
    var body: some View {
        VStack{
            TextField("Email", text: $email)
                .frame(width: 250, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                ).padding(5)
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
            
            SecureField("Password", text: $password)
                .frame(width: 250, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                ).padding(5)
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
            
            TextField("Name", text: $name)
                .frame(width: 250, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                ).padding(5)
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
            
            TextField("Surname", text: $surname)
                .frame(width: 250, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                ).padding(5)
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
            
            Picker("Espionage", selection: $genre) {
                ForEach(genres, id: \.self) {
                    Text($0)
                }
            }
            .frame(width: 250, height: 30, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.purple, lineWidth: 4)
            ).padding(5)
            .multilineTextAlignment(.center)
            
            HStack{
                Button("Register") {
                    loginVM.SignUp(email: email, password: password, name: name, surname: surname, genre: genre)
                }.padding()
                .frame(width: 100, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                )
                .foregroundColor(.purple)
                
            }
            .padding(.top, 20)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(loginVM: LogInVM())
    }
}
