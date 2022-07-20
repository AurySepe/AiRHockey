//
//  HasAudio.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 20/07/22.
//

import Foundation
import RealityKit
import Combine

struct AudioComponent : Component
{
    var resource : AudioResource
    var audioSubscription : Cancellable?

}

protocol HasAudio where Self:Entity { }

extension HasAudio
{
    var audio : AudioComponent? {
        get {self.components[AudioComponent.self]}
        set {self.components[AudioComponent.self] = newValue}
    }
    
    
    
}

extension HasAudio
{
    func addPlayOnCollision(){
        
        guard let scene = self.scene, let audio = self.audio else {
            return
        }
        
        
        self.audio?.audioSubscription = scene.subscribe(to: CollisionEvents.Began.self, on: self) { event in
            guard let entitaSbattuta = event.entityB as? HasPhysics else {return}
            if entitaSbattuta.physicsBody?.mode == .dynamic
            {
                let _ : AudioPlaybackController = self.playAudio(audio.resource)
            }
            
        }
        
    }
}


