//
//  Dischetto.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import Foundation
import RealityKit


class Dischetto : Entity, HasPhysics,HasCollision,HasAnchoring,HasModel
{
    required init(modelComponent : ModelComponent,transform : Transform) {
        super.init()
        self.model = modelComponent
        self.collision = .init(shapes: [.generateSphere(radius: 0.01)])
        self.transform = transform
        self.physicsBody = PhysicsBodyComponent(massProperties: .default, material: .generate(friction: 0, restitution: 1), mode: .dynamic)
        self.physicsMotion = .init()
        }
    
    required init() {
        super.init()
    }
    
    
    
        
}

