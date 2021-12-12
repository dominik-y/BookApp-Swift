//
//  DetailBookView.swift
//  BookApp
//
//  Created by Dominik Maric on 10.12.2021..
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailBookView: View {
    
    var book: Book
    var numberOfLikes: Int
    @State var tapped = false
    @State var numLike = 0
    @ObservedObject var detailVM : DetailBookVM
    
    var body: some View {
        VStack{
            ScrollView{
                Group{
                    WebImage(url: URL(string: book.url))
                        .resizable()
                    //.scaledToFill()
                    //.frame(height: 150, alignment: .center)
                    
                    Text(book.title)
                        .font(.headline)
                        .padding(.top, 20)
                    
                    Text(book.author)
                        .font(.headline)
                    
                    Text(book.description)
                        .padding(.top, 20)
                    
                    
                    Text("Publisher: " + book.publisher)
                        .padding(.top, 20)
                }
                
                Text("Comments")
                    .padding(.top, 20)
                
                ScrollView{
                    ForEach(detailVM.allComments, id: \.self) { comment in
                        if comment.bookName == book.title{
                            Text(comment.name + " " + comment.surname)
                            Text(comment.comment)
                            Text("---------")
                        }
                    }
                }
                .frame(width: 400, height: 100, alignment: .center)
                
                //NavigationLink(destination: CommView(book: book, detailVM: detailVM), isActive: $tapped){
                Text("This book was liked by \(numLike) people")
                //}
                //.padding(.top, 20)
                
                
                HStack{
                    NavigationLink(destination: CommView(book: book, detailVM: detailVM), isActive: $tapped){
                        Button {
                            tapped = true
                        }
                    label: {
                        Text("Comment")
                    }
                    .frame(width: 100, height: 30, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.purple, lineWidth: 4)
                    )
                    .foregroundColor(.purple)
                    }
                    
                    Button {
                        numLike+=1
                        detailVM.sendLike(name: detailVM.getName(), surname: detailVM.getSurname(), bookName: book.title)
                    }
                label: {
                    Text("Like")
                }
                .frame(width: 100, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                )
                .foregroundColor(.purple)
                }
            }
            
        }
        .onAppear{
            self.numLike = numberOfLikes
            detailVM.getDocumentId(name: detailVM.getName(), surname: detailVM.getSurname(), bookName: book.title)
        }
    }
}

