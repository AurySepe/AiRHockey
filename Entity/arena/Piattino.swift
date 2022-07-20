//
//  Piattino.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 15/07/22.
//

import Foundation
import RealityKit


class Piattino : Entity, HasPhysics,HasCollision,HasAnchoring,HasModel,IsMovable,IsRestricted,HasAudio,HasNetwork,HasHitSound
{
    required init(modelComponent : ModelComponent,movableComponent : MovableComponent,tranform : Transform,restrictionComponent : RestrictionComponent,audioComponent : AudioComponent,network:NetworkComponent,hitSound:HitSoundComponent) {
        super.init()
        self.model = modelComponent
        self.physicsBody = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .kinematic)
        self.physicsMotion = .init()
        self.collision = .init(shapes: [.generateSphere(radius: 0.017)])
        self.transform = tranform
        self.movable = movableComponent
        self.audio = audioComponent
        self.hitSound = hitSound
        self.network = network
        self.restriction = restrictionComponent
        }
    
    required init() {
        super.init()
    }
}
