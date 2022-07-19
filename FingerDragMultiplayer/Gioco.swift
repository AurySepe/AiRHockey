//
//  Gioco.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import Foundation
import RealityKit
import Combine


class Gioco : ObservableObject
{
    var sfera : Entity?
    
    func muovi()
    {
        if let sfera = sfera as? HasPhysics {
            sfera.applyLinearImpulse(.init(x: 0, y: 0, z: -20), relativeTo: sfera.parent)
            print("prova")
        }
    }
    
    var prova : Cancellable?
}
