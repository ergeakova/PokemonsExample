//
//  Card.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 31.07.2022.
//

import SwiftUI

struct Card: View {
    @State var utl = Utils()
    @StateObject var pokemonService = PokemonService.shared
    
    @State var turnDirection = true
    @State var axis = (CGFloat(1),CGFloat(0),CGFloat(0))
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    @State var shownPokemon = 0
    
    @State var pokemons: [Result] = []
    @State var allPokemonCount = 0
    var body: some View {
        VStack{
            
            
            HStack{
                Image("icRefresh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: utl.scWidth * 0.15)
                    .padding()
                    .onTapGesture {
                        print("click")
                        Task{
                            await resetPokemons()
                            flipFlashcard()
                        }
                    }
                
                Spacer()
            }.frame(height: utl.scHeigth * 0.1)
                .border(.black)
            
            
            
            
            VStack{
                VStack{
                    if pokemons.count > 0 {
                        VStack{
                            Text(pokemons[shownPokemon].name)
                        }.rotation3DEffect(.degrees(contentRotation), axis: axis)
                    }else{
                        Text("Loading").rotation3DEffect(.degrees(contentRotation), axis: axis)
                    }
                    
                }.frame(width: utl.scWidth * 0.7, height: utl.scHeigth * 0.5)
                    .background(Color(.white))
                    .cornerRadius(15)
                    .padding()
                
            }.frame(width: utl.scWidth, height: utl.scHeigth * 0.8)
                .padding()
                .onTapGesture(){
                    Task{
                        if shownPokemon == allPokemonCount{
                            await resetPokemons()
                        }
                    }
                    
                    
                    if shownPokemon == pokemons.count - 1{
                        Task{
                            await getPokemonResult()
                        }
                    }
                    if shownPokemon < pokemons.count - 1{
                        shownPokemon+=1
                        flipFlashcard()
                    }
                    
                    
                    
                }.rotation3DEffect(.degrees(flashcardRotation), axis: axis)
                .onReceive(utl.orientationChanged) { _ in
                    utl = Utils()
                }.onAppear(){
                    Task{
                        await getPokemonResult()
                        allPokemonCount = pokemonService.allPokemonCount
                    }
                }
        }.onReceive(utl.orientationChanged) { _ in
            utl = Utils()
        }.frame(width: utl.scWidth, height: utl.scHeigth)
            .background(Color("bgColor"))
            .padding()
    }
    
    func resetPokemons() async{
        pokemonService.urlString = pokemonService.defaultUrl
        pokemons.removeAll()
        await getPokemonResult()
        shownPokemon = 0
    }
    
    func getPokemonResult() async{
        do{
            pokemons.append(contentsOf: try await pokemonService.getResults().results)
            
        }catch{
            print("Error")
        }
    }
    
    func flipFlashcard() {
        turnDirection = turnDirection ? true : false
        axis = turnDirection ? (CGFloat(1),CGFloat(0),CGFloat(0)) : (CGFloat(0),CGFloat(1),CGFloat(0))
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            turnDirection.toggle()
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card().previewLayout(.sizeThatFits)
    }
}
