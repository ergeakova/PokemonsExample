//
//  Card.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 31.07.2022.
//

import SwiftUI

struct Card: View {
    @State var utl = Utils()
    
    @State var turnDirection = true
    @State var axis = (CGFloat(1),CGFloat(0),CGFloat(0))
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Text("Deneme")
                }.rotation3DEffect(.degrees(contentRotation), axis: axis)
            }.frame(width: utl.scWidth * 0.7, height: utl.scHeigth * 0.5)
                .background(Color(.white))
                .cornerRadius(15)
                .padding()
            
        }.onTapGesture(){
            print("clicked")
            print(turnDirection)
            flipFlashcard()
        }.rotation3DEffect(.degrees(flashcardRotation), axis: axis)
        .onReceive(utl.orientationChanged) { _ in
            utl = Utils()
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
