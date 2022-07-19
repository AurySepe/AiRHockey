//
//  Goal.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import Foundation
import RealityKit
import SwiftUI
import Combine

class GoalEntity : Entity, HasModel, HasAnchoring, HasCollision,IsGoal{
    
    
    required init(goalComponent : GoalComponent) {
            super.init()
            
        self.components[CollisionComponent.self] = CollisionComponent(
                shapes: [.generateBox(size: [0.5,0.5,0.5])],
                mode: .trigger,
              filter: .sensor
            )
            
        self.components[ModelComponent.self] = ModelComponent(
                mesh: .generateBox(size: [0.5,0.5,0.5]),
                materials: [SimpleMaterial(
                    color: .green,
                    isMetallic: false)
                ]
            )
        self.components[GoalComponent.self] = goalComponent
        }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    convenience init(goalComponent : GoalComponent, position: SIMD3<Float>) {
            self.init(goalComponent : goalComponent)
            self.position = position
    }
    
    
    
    
    
}
