//
//  Wall.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 17/07/22.
//

import Foundation
import RealityKit


class Wall: Entity, HasCollision,HasModel,HasAnchoring,IsBounceable,HasAudio,HasNetwork,HasHitSound
{
    
    
    required init(transformComponent : Transform,size : SIMD3<Float>,bounceComponent: BounceComponent,audioComponent : AudioComponent,network : NetworkComponent,hitSound : HitSoundComponent) {
        super.init()
        self.model = .init(mesh: .generateBox(size: size), materials: [SimpleMaterial(color: .white, isMetallic: false)] )
//        self.physicsBody = .init(massProperties: .default, material: .generate(friction: 0, restitution: 1), mode: .static)
        self.generateCollisionShapes(recursive: true)
        self.transform = transformComponent
//        self.physicsMotion = .init()
        self.bounce = bounceComponent
        self.audio = audioComponent
        self.network = network
        self.hitSound = hitSound
        self.synchronization = nil
        
    }
    
    required init() {
        super.init()
    }
}
