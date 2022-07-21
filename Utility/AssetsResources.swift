//
//  AssetsResources.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 20/07/22.
//

import Foundation
import RealityKit


class AssetsRsources
{
    static var tavolo : ModelEntity = {
        let scene = try! Assets.loadTavolo()
        let entity = scene.findEntity(named: "Mesh")!
        print(entity.components)
        return entity as! ModelEntity
        
    }()
}
