//
//  Wall.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 17/07/22.
//

import Foundation
import RealityKit


class Wall: Entity, HasCollision,HasModel,HasAnchoring,IsBounceable
{
    
    
    required init(transformComponent : Transform,size : SIMD3<Float>,bounceComponent: BounceComponent) {
        super.init()
        self.model = .init(mesh: .generateBox(size: size), materials: [SimpleMaterial(color: .white, isMetallic: false)] )
//        self.physicsBody = .init(massProperties: .default, material: .generate(friction: 0, restitution: 1), mode: .kinematic)
        self.generateCollisionShapes(recursive: true)
        self.transform = transformComponent
//        self.physicsMotion = .init()
        self.bounce = bounceComponent
        self.synchronization = nil
        
    }
    
    required init() {
        super.init()
    }
}
