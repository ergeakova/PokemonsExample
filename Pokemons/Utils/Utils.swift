//
//  Utils.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 31.07.2022.
//

import Foundation
import SwiftUI

struct Utils{
    let scWidth = UIScreen.main.bounds.width
    let scHeigth = UIScreen.main.bounds.height
    
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
}
