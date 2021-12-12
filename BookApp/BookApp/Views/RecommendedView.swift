//
//  RecommendedView.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import SwiftUI
import FirebaseAuth

struct RecommendedView: View {
    
    @ObservedObject var recVM : RecommendedVM
    
    var body: some View {
        VStack{
        
            Text(recVM.getGenre())
                .font(.headline)
            
        ScrollView{
            ForEach(recVM.allRecommendedBooks, id: \.self){ book in
                HStack{
                    Text(book.title).lineLimit(2)
                    Spacer()
                    HStack{
                        Image(systemName: "message")
                        Text(String(book.commNum))
                    }
                    
                    HStack{
                        Image(systemName: "hand.thumbsup")
                        Text(String(book.likeNum))
                    }
                }
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
        RecommendedView(recVM: RecommendedVM())
    }
}
