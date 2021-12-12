//
//  RecommendedView.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct RecommendedView: View {
    
    @ObservedObject var recVM : RecommendedVM
    @ObservedObject var bookVM : BookVM
    
    var body: some View {
        VStack{
            
            Text(recVM.getGenre())
                .font(.headline)
            
            ScrollView{
                ForEach(recVM.allRecommendedBooks, id: \.self){ book in
                    HStack{
                        WebImage(url: URL(string: book.url))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 150)
                            .cornerRadius(5)
                        VStack {
                            Text(book.title)
                        }
                        HStack {
                            Image(systemName: "message")
                            Text(String(bookVM.getBookCommentNum(bookName: book.title)))
                            
                            Image(systemName: "hand.thumbsup")
                            Text(String(bookVM.getBookLikesNum(bookName: book.title)))
                        }
                    }
                    .padding(15)
                    Spacer()
                }
            }.clipped()
        }
        .onAppear{
            for user in recVM.allUsers{
                if user.id == Auth.auth().currentUser?.uid{
                    recVM.getAllBooks(genre: user.genre)
                }
            }
        }
    }
}

struct RecommendedView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedView(recVM: RecommendedVM(), bookVM: BookVM())
    }
}
