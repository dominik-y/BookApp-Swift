//
//  BookTabView.swift
//  BookApp
//
//  Created by Dominik Maric on 08.12.2021..
//

import SwiftUI

struct BookTabView: View {
    var bookVM: BookVM
    var recVM: RecommendedVM
    var detailVM : DetailBookVM
    var body: some View {
        TabView{
            BookListView(bookVM: bookVM, detailVM: detailVM)
                .tabItem{
                    Image(systemName: "book")
                    Text("Books")
                }
            FavoritesView()
                .tabItem{
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            RecommendedView(recVM: recVM)
                .tabItem{
                    Image(systemName: "pencil")
                    Text("Recommended")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BookTabView_Previews: PreviewProvider {
    static var previews: some View {
        BookTabView(bookVM: BookVM(), recVM: RecommendedVM(), detailVM: DetailBookVM())
    }
}
