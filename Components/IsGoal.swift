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
    var nearbyService : NearbyService
    var player : Int
    var arena : Arena
    var audioResource : AudioResource

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
        let nearbyService = goal.nearbyService
        let audio = goal.audioResource
        
        self.goal?.goalSubscription = scene.subscribe(to: CollisionEvents.Began.self, on: self) { event in
            if event.entityB == self.goal?.arena.dischetto
            {
                self.goal?.arena.resetDischetto()
                
                
                if goal.player == 1
                {
                    nearbyService.punteggio1 += 1
                }
                else if goal.player == 2
                {
                    nearbyService.punteggio2 += 1
                }
                nearbyService.send(msg: "\(nearbyService.punteggio1),\(nearbyService.punteggio2)")
                self.playAudio(audio)
            }
            
        }
        
    }
}


