//
//  Utils.swift
//  Pokemons
//
//  Created by Erge Gevher Akova on 31.07.2022.
//

import Foundation
import SwiftUI

class Utils: ObservableObject{
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
}
