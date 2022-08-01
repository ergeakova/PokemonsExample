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
        Card()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
