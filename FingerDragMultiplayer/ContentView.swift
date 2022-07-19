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
    
    @EnvironmentObject var game : Gioco
    @EnvironmentObject var pointTracker : PointsViewModel
//    let nearbyService = NearbyService(serviceType: "gt-airhockey")
    var body: some View {
        ZStack
        {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("punteggio 1:\(pointTracker.punteggioGiocatore1)")
                Text("punteggio 2:\(pointTracker.punteggioGiocatore2)")
            }
        }
        
    }
}

extension ContentView : NearbyServiceDelegate
{
    func didReceive(msg: String)
    {
        print(msg)
    }

}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var game : Gioco
    @EnvironmentObject var pointTracker : PointsViewModel
    let nearbyService : NearbyService = NearbyService()
    
    func makeUIView(context: Context) -> ARView {
        GoalComponent.registerComponent()
        
        let arView = ARView(frame: .zero)
        let arena = Arena(transformComponent: .init(scale: .one, rotation: .init(), translation: .init(x: 0, y: 0, z: 0)), movableComponent: .init(view: arView),size: .init(x: 0.3, y: 0.1, z: 0.6))

        arView.debugOptions.update(with: .showPhysics)
        
        arView.scene.anchors.append(arena)
//        arView.scene.synchronizationService = try?
//        MultipeerConnectivityService(session: nearbyService.session )
        

////        game.prova = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
////            timer += Float(event.deltaTime)
////            if timer >= 3
////            {
////                arena.dischetto.physicsBody?.mode = .dynamic
////            }
            
//            
//        }
        arena.activateChildren()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

