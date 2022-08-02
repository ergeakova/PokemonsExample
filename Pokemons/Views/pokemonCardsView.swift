//
//  Card.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 31.07.2022.
//

import SwiftUI

struct pokemonCardsView: View {
    @State var utl = Utils()
    @StateObject var pokemonService = PokemonService.shared
    
    @State var turnDirection = true
    @State var axis = (CGFloat(1),CGFloat(0),CGFloat(0))
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    @State var shownPokemon = 0
    @State var pokemons: [ResultModel] = []
    @State var allPokemonCount = 0
    @State var shownPokemonStat: PokemonStatsModel?
    
    var body: some View {
        
        VStack{
            HStack{
                Image("icRefresh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.15, alignment: .trailing)
                    .padding(.top)
                    .onTapGesture {
                        Task{
                            await resetPokemons()
                            let showPokemonUrl = pokemons[shownPokemon].url
                            await getPokemonStats(pokemon: showPokemonUrl)
                            flipFlashcard()
                        }
                    }
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
            
            VStack{
                VStack{
                    if pokemons.count > 0 && shownPokemonStat != nil {
                        VStack{
                            Text(shownPokemonStat!.name.capitalized)
                                .font(.title)
                            
                            AsyncImage(url: URL(string: (shownPokemonStat?.sprites.front_default)!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: .infinity, height: .infinity, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                            
                            HStack{
                                VStack{
                                    Text(shownPokemonStat!.stats[0].stat.name)
                                        .font(.title2)
                                    Text("\(shownPokemonStat!.stats[0].base_stat)")
                                        .font(.title2)
                                }.padding(.horizontal)
                                VStack{
                                    Text(shownPokemonStat!.stats[1].stat.name)
                                        .font(.title2)
                                    Text("\(shownPokemonStat!.stats[1].base_stat)")
                                        .font(.title2)
                                }.padding(.horizontal)
                                VStack{
                                    Text(shownPokemonStat!.stats[2].stat.name)
                                        .font(.title2)
                                    Text("\(shownPokemonStat!.stats[2].base_stat)")
                                        .font(.title2)
                                }.padding(.horizontal)
                            }
                        }.rotation3DEffect(.degrees(contentRotation), axis: axis)
                    }else{
                        Text("Loading...").rotation3DEffect(.degrees(contentRotation), axis: axis)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                    .background(Color(.white))
                    .cornerRadius(15)
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
                .padding()
                .onTapGesture(){
                    Task{
                        if shownPokemon < pokemons.count - 1{
                            flipFlashcard()
                            shownPokemon+=1
                        }
                        
                        if shownPokemon == allPokemonCount{
                            await resetPokemons()
                        }
                        
                        let showPokemonUrl = pokemons[shownPokemon].url
                        await getPokemonStats(pokemon: showPokemonUrl)
                        
                    }
                    
                    if shownPokemon == pokemons.count - 2{
                        Task{
                            await getPokemonResult()
                        }
                    }
                    
                }.rotation3DEffect(.degrees(flashcardRotation), axis: axis)
                .onAppear(){
                    Task{
                        await getPokemonResult()
                        let showPokemonUrl = pokemons[shownPokemon].url
                        await getPokemonStats(pokemon: showPokemonUrl)
                        allPokemonCount = pokemonService.allPokemonCount
                    }
                }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .background(Color("bgColor"))
            .onReceive(utl.orientationChanged) { _ in
                utl = Utils()
            }
    }
    
    func getPokemonStats(pokemon: String) async{
        do{
            shownPokemonStat = try await pokemonService.getStats(url: pokemon)
        }catch{
            print{"Error Details"}
        }
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
        let animationTime = 0.3
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
        pokemonCardsView()
    }
}
