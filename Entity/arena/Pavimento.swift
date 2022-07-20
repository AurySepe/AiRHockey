//
//  Pavimento.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 17/07/22.
//

import Foundation
import RealityKit


class Pavimento : Entity, HasPhysics, HasCollision,HasModel,HasAnchoring
{
    
    
    required init(transformComponent : Transform,size : SIMD3<Float>) {
        super.init()
        self.model = .init(mesh: .generateBox(size:size ), materials: [SimpleMaterial(color: .white, isMetallic: false)] )
        self.generateCollisionShapes(recursive: true)
        self.physicsBody = .init(massProperties: .default, material: .generate(friction: 0, restitution: 0), mode: .static)
        self.transform = transformComponent
        self.physicsMotion = .init()
        self.synchronization = nil
        
        
    }
    
    required init() {
        super.init()
    }
}


