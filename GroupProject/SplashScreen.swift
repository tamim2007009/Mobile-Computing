//
//  SplashScreen.swift
//  GroupProject
//
//  Created by Gaming Lab on 15/12/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
        VStack{
            Image("asdf")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .frame(height: 200)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
