//
//  ContentView.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 31.07.2022.
//

import SwiftUI

struct ContentView: View {
   @State var utl = Utils()
    
    var body: some View {
        VStack{
            HStack{
                Image("icRefresh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: utl.scWidth * 0.15)
                    .padding()
                Spacer()
            }.frame(height: utl.scHeigth * 0.2)
            VStack{
                Card()
            }.frame(height: utl.scHeigth * 0.8)
        }.onReceive(utl.orientationChanged) { _ in
            utl = Utils()
        }.frame(width: utl.scWidth, height: utl.scHeigth)
            .background(Color("bgColor"))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
