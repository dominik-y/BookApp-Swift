//
//  BookListView.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var bookVM : BookVM
    @ObservedObject var detailVM : DetailBookVM
    
    var body: some View {
        VStack{
            TextField("Search", text: $bookVM.searchedBook)
                .frame(width: 250, height: 30, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 4)
                )
                .multilineTextAlignment(.center)
            
            
            ScrollView{
                ForEach(bookVM.searchedAllBooks, id: \.self){ book in
                    NavigationLink(destination: DetailBookView(book: book, numberOfLikes: bookVM.getBookLikesNum(bookName: book.title), detailVM: detailVM)){
                    HStack{
                        Text(book.title)
                        Spacer()
                        HStack{
                            Image(systemName: "message")
                            Text(String(bookVM.getBookCommentNum(bookName: book.title)))
                        }
                        
                        HStack{
                            Image(systemName: "hand.thumbsup")
                            Text(String(bookVM.getBookLikesNum(bookName: book.title)))
                        }
                    }
                    .padding(.bottom, 25)
                }
                }
            }.clipped()
        }
        .onAppear{
            bookVM.getAllLikes()
            bookVM.getAllComments()
            bookVM.getAllBooks()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(bookVM: BookVM(), detailVM: DetailBookVM())
    }
}


