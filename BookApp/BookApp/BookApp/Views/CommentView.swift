//
//  CommentView.swift
//  BookApp
//
//  Created by Dominik Maric on 10.12.2021..
//

import SwiftUI

struct CommentView: View {
    
    var book: Book
    var detailVM: DetailBookVM
    @State var comment = ""
    
    var body: some View {
        TextField("Name", text: $comment)
            .frame(width: 250, height: 30, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.purple, lineWidth: 4)
            )
            .multilineTextAlignment(.center)
        
        Button {
            detailVM.sendComment(comm: comment, name: detailVM.getName(), surname: detailVM.getSurname(), bookName: book.title)
        } label: {
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
