//
//  ContentView.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 14/07/22.
//

import SwiftUI
import RealityKit
import MultipeerConnectivity
import Combine

struct ContentView : View {
    
    @EnvironmentObject var nearbyService : NearbyService
    @EnvironmentObject var pointTracker : PointsViewModel
    var body: some View {
        
        if nearbyService.isConnected
        {
            ZStack
            {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                VStack
                {
                    Spacer()
                    Text("Player1 : \(pointTracker.punteggioGiocatore1), Player2 : \(pointTracker.punteggioGiocatore2)")
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
    @EnvironmentObject var pointTracker : PointsViewModel
    static var s : Cancellable?
    
    func makeUIView(context: Context) -> ARView {
        GoalComponent.registerComponent()
        
        let arView = ARView(frame: .zero)
        let arena = Arena(transformComponent: .init(scale: .one, rotation: .init(), translation: .zero ), movableComponent: .init(view: arView),isHost: nearbyService.isHost,nearbyService: nearbyService,pointTracker : pointTracker)

        arView.debugOptions.update(with: .showPhysics)

        arView.scene.anchors.append(arena)
        arena.activateChildren()
       
        arView.scene.synchronizationService = try?
        MultipeerConnectivityService(session: nearbyService.session )
        print(arena.dischetto.transform.translation)
        

//        ARViewContainer.s = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
//            
//            print("disco \(arena.dischetto.transform.translation)")
//            print(arena.pavimento.transform.translation)
////            
//        }
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
