//
//  LogInVM.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI


class LogInVM : ObservableObject{
    
    @Published var isLogged = false
    @Published var shouldRegistrate = false
    @Published var shouldAlertEmail = false
    @Published var shouldAlertCredentials = false

 
    func SignUp(email: String, password: String, name: String, surname: String, genre: String){
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print("---------------------")
                print(user.uid)
                self.addData(name: name, surname: surname, id: user.uid, genre: genre)
            } else {
                print(error ?? "")
            }
        }
    }
    
    
    func addData(name: String, surname: String, id: String, genre: String){
            
                Firestore.firestore().collection("User").addDocument(data: [
                    "name": name,
                    "surname": surname,
                    "userId": id,
                    "genre": genre
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Yea baby")
                    }
                }
            
        }
    
    
    func isEmailValid(email: String) -> Bool {
           // criteria in regex.  See http://regexlib.com
           let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
       }
    
//
//    public func isValidPassword() -> Bool {
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
//        return NSPredicate(format: "SELF MATCHES %@", passwordTest).evaluate(with: self)
//    }
    
    
    func logIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                    print(error)
                    if self.isEmailValid(email: email) == false{
                        self.shouldAlertEmail = true
                    }
                    else{
                        self.shouldAlertCredentials = true
                    }
                } else {
                    print("LogedIn")
                    self.isLogged = true
                }
            }
    }
}
