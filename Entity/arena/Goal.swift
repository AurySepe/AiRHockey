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
    
    
    required init(goalComponent : GoalComponent,mesh : MeshResource,transform : Transform) {
            super.init()
            
        self.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateConvex(from: mesh)],
                mode: .trigger,
              filter: .sensor
            )
            
        self.components[ModelComponent.self] = ModelComponent(
            mesh: mesh,
                materials: [SimpleMaterial(
                    color: .green,
                    isMetallic: false)
                ]
            )
        self.components[GoalComponent.self] = goalComponent
        self.transform = transform
        }
    
    required init() {
        super.init()
    }
    
    
    
    
    
    
}
