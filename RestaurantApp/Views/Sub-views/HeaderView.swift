//
//  HeaderView.swift
//  RestaurantApp
//
//  Created by l on 12/16/23.
//

import SwiftUI

struct HeaderView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("Logo")
                    if(isLoggedIn) {
                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Spacer()
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(maxHeight: 40)
                                    .padding(.trailing)
                                    .foregroundColor(.accentGreen)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxHeight: 50)
        .onAppear() {
            if UserDefaults.standard.bool(forKey: "isLogin") {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
}

#Preview {
    HeaderView()
}
