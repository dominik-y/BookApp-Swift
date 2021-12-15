//
//  SettingsView.swift
//  BookApp
//
//  Created by Dominik Maric on 15.12.2021..
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var loginVM: LogInVM
    
    var body: some View {
        VStack {
            Text("name")
            
            Spacer()
            
            Button {
                loginVM.SignOut()
            } label: {
                Text("Sign out")
            }

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
    }
}
