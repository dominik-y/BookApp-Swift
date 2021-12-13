//
//  DetailBookView.swift
//  BookApp
//
//  Created by Dominik Maric on 10.12.2021..
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailBookView: View {
    
    @ObservedObject var bookVM : BookVM
    var book: Book
    var numberOfLikes: Int
    @State var tapped = false
    @ObservedObject var detailVM : DetailBookVM
    
    var body: some View {
        NavigationView{
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
                    
                    if bookVM.favorite(book: book) == false{
                        Image(systemName: "star")
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                bookVM.addFavorite(book: book)
                            }
                    }
                    else{
                        Image(systemName: "star.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                bookVM.addFavorite(book: book)
                            }
                    }
                    
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
                
                
                HStack{
                    NavigationLink(destination: CommView(book: book, detailVM: detailVM).navigationBarBackButtonHidden(true), isActive: $tapped){
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
        
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
        
        .onAppear{
            detailVM.getDocumentId(name: detailVM.getName(), surname: detailVM.getSurname(), bookName: book.title)
        }
    }
}

