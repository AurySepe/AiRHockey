//
//  ContentView.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import SwiftUI
import RealityKit
import MultipeerConnectivity

struct ContentView : View {
    
    @EnvironmentObject var nearbyService : NearbyService
    var body: some View {
        
        if nearbyService.isConnected
        {
            ZStack
            {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                VStack
                {
                    Spacer()
                    Text("Giocatore1 : \(nearbyService.punteggio1), Giocatore2 : \(nearbyService.punteggio2)")
                }
            }
            
        }
        else
        {
            MenuView()
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var nearbyService : NearbyService
    
    func makeUIView(context: Context) -> ARView {
        GoalComponent.registerComponent()
        
        let arView = ARView(frame: .zero)
        let arena = Arena(transformComponent: .init(scale: .one, rotation: .init(), translation: .init(x: 0, y: 0, z: 0)), movableComponent: .init(view: arView),size: .init(x: 0.3, y: 0.1, z: 0.6),isHost: nearbyService.isHost,nearbyService: nearbyService)

        arView.debugOptions.update(with: .showPhysics)

        arView.scene.anchors.append(arena)
        arena.activateChildren()
       
        arView.scene.synchronizationService = try?
        MultipeerConnectivityService(session: nearbyService.session )
        

////        game.prova = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
////            timer += Float(event.deltaTime)
////            if timer >= 3
////            {
////                arena.dischetto.physicsBody?.mode = .dynamic
////            }
            
//            
//        }
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

