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
    @State var tapped = false
    @ObservedObject var detailVM : DetailBookVM
    
    var body: some View {
        VStack{
            Group{
            WebImage(url: URL(string: book.url))
                .resizable()
                .frame(width: 150, height: 200, alignment: .center)
            
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
            .frame(width: 300, height: 100, alignment: .center)
            
            
                
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
                
        }
    }
}

