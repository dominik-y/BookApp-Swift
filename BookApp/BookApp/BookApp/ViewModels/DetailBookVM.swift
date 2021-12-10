//
//  DetailBookVM.swift
//  BookApp
//
//  Created by Dominik Maric on 10.12.2021..
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DetailBookVM: ObservableObject{
    
    @Published var allComments = [Comment]()
    @Published var bookComments = [Comment]()
    @Published var allUsers = [User]()
    
    
    init(){
        getAllComments()
        getUsers()
    }
    
    func getUsers(){
        Firestore.firestore().collection("User").addSnapshotListener{ (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else{
                return
            }
            self.allUsers = documents.map{ (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let surname = data["surname"] as? String ?? ""
                let id = data["userId"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let user = User(name: name, surname: surname, genre: genre, id: id)
                return user
            }
            print("AAAAAAA")
            print(self.allUsers)
        }
    }
    
    func getAllComments(){
        Firestore.firestore().collection("Comments").addSnapshotListener{ (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else{
                return
            }
            self.allComments = documents.map{ (queryDocumentSnapshot) -> Comment in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let surname = data["surname"] as? String ?? ""
                let bookName = data["bookName"] as? String ?? ""
                let comm = data["comment"] as? String ?? ""
                let comment = Comment(bookName: bookName, name: name, surname: surname, comment: comm)
                return comment
            }
        }
    }
    
    func getBookComment(bookName: String){
        self.bookComments = []
        for comment in allComments{
            if bookName == comment.bookName{
                bookComments.append(comment)
            }
        }
    }
    
    func sendComment(comm: String, name: String, surname: String, bookName: String){
        Firestore.firestore().collection("Comments").addDocument(data: [
            "name": name,
            "surname": surname,
            "comment": comm,
            "bookName": bookName
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Yea baby")
            }
        }
    }
    
    func getName() -> String{
        for user in allUsers{
            if user.id == Auth.auth().currentUser?.uid{
                return user.name
            }
        }
        return ""
    }
    
    func getSurname() -> String{
        for user in allUsers{
            if user.id == Auth.auth().currentUser?.uid{
                return user.surname
            }
        }
        return ""
    }
    
    
}
