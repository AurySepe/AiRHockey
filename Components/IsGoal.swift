//
//  IsGoal.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import Foundation
import RealityKit
import Combine

struct GoalComponent : Component
{
    var goalSubscription : Cancellable?
    var pointTracker : PointsViewModel
    var player : Int

}

protocol IsGoal { }

extension IsGoal where Self: Entity
{
    var goal : GoalComponent? {
        get {self.components[GoalComponent.self]}
        set {self.components[GoalComponent.self] = newValue}
    }
    
    
    
}

extension IsGoal where Self: HasCollision
{
    func addCollisions(){
        
        guard let scene = self.scene, let goal = self.goal else {
            return
        }
        let pointTracker = goal.pointTracker
        
        self.goal?.goalSubscription = scene.subscribe(to: CollisionEvents.Began.self, on: self) { event in
            
            if goal.player == 1
            {
                pointTracker.punteggioGiocatore1 += 1
            }
            else if goal.player == 2
            {
                pointTracker.punteggioGiocatore2 += 1
            }
            
        }
        
    }
}


