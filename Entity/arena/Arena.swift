//
//  Arena.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 17/07/22.
//

import Foundation
import RealityKit


class Arena : Entity,HasAnchoring
{
    var walls : [Wall] = []
    var dischetto : Dischetto = Dischetto()
    var piattini : [Piattino] = []
    var pavimento : Pavimento = Pavimento()
    
    required convenience init(transformComponent : Transform,movableComponent : MovableComponent,size : SIMD3<Float>) {
        
        self.init(movableComponent: movableComponent,size:size)
        self.transform = transformComponent
        
        
    }
    
    required init(movableComponent : MovableComponent,size : SIMD3<Float>) {
        self.size = size
        super.init()
        walls.append(contentsOf: createWalls())
        self.dischetto = createDisco()
        self.piattini.append(createPiattino(movableComponent: movableComponent))
        self.pavimento = createPavimento()
        self.children.append(contentsOf: walls)
        self.children.append(contentsOf: piattini)
        self.children.append(dischetto)
        self.children.append(pavimento)
        
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func activateChildren()
    {
        for piattino in piattini {
            piattino.installMovement()
            piattino.addRestriction()
        }
        for wall in walls
        {
            wall.addBounce()
        }
//        self.dischetto.addForce(.init(x: 50, y: 0, z: 0), relativeTo: self)
    }
    
    func createWalls() -> [Wall]
    {
        var wall : [Wall] = []
        for i in 0..<wallRotation.count
        {
            
            wall.append(Wall(transformComponent: Transform(scale: .one, rotation: wallRotation[i], translation: wallPosition[i]), size: wallSize[i], bounceComponent: .init(directionOfBounce: wallBounceDirection[i])))
        }
        
        return wall
    }
    
    func createPavimento() -> Pavimento
    {
        Pavimento(transformComponent: .init(scale: .one, rotation: .init(), translation: .zero),size: pavimentoSize )
    }
    
    func createPiattino(movableComponent: MovableComponent) -> Piattino
    {
        return Piattino(modelComponent: .init(mesh: .generateSphere(radius: radiusPiattino), materials: [SimpleMaterial.init(color: .blue, isMetallic: false)]), movableComponent: movableComponent, tranform: .init(scale: .one , rotation: .init(), translation: piattinoPosition),restrictionComponent: .init(box: (SIMD2<Float>(x: -pavimentoSize.x/2 + wallSize[0].z + radiusPiattino + radiusDischetto*2, y: pavimentoSize.x/2 - wallSize[0].z - radiusPiattino - radiusDischetto*2),SIMD2<Float>(x: -pavimentoSize.z/2 + wallSize[0].z + radiusPiattino + radiusDischetto*2, y: pavimentoSize.z/2 - wallSize[0].z - radiusPiattino - radiusDischetto*2))))
    }
    
    func createDisco() -> Dischetto
    {
        return Dischetto(modelComponent: .init(mesh: .generateSphere(radius: radiusDischetto), materials: [SimpleMaterial(color: .red, isMetallic: false)]),transform: .init(scale: .one, rotation: .init(), translation: dischettoPosition))
    }
    
    
    
    
    var size : SIMD3<Float> = .init(x: 0.3, y: 0.1, z: 0.6)
    var pavimentoSize : SIMD3<Float>{ get{ .init(x: size.x, y: size.y/4, z: size.z)}}
    var wallSize: [SIMD3<Float>] {get{
    [
        .init(x: size.x, y: size.y/2, z: size.y/2),
        .init(x: size.z, y: size.y/2, z: size.y/2),
        .init(x: size.x, y: size.y/2, z: size.y/2),
        .init(x: size.z, y: size.y/2, z: size.y/2)
    ]}}
    var wallPosition:
    [SIMD3<Float>] {get{
    [
        .init(x: 0, y: pavimentoSize.y/2 + wallSize[0].y/2, z: -pavimentoSize.z/2 + wallSize[0].z/2),
        .init(x: pavimentoSize.x/2 - wallSize[1].z/2, y: pavimentoSize.y/2 + wallSize[1].y/2, z: 0),
        .init(x: 0, y: pavimentoSize.y/2 + wallSize[2].y/2, z: pavimentoSize.z/2 - wallSize[2].z/2),
        .init(x: -pavimentoSize.x/2 + wallSize[3].z/2, y: pavimentoSize.y/2 + wallSize[3].y/2, z: 0)
        
    ]}}
    var wallRotation : [simd_quatf] {get{
    [
        .init(angle: 0, axis: .init(x: 0, y: 1, z: 0)),
        .init(angle: .pi/2, axis: .init(x: 0, y: 1, z: 0)),
        .init(angle: .pi, axis: .init(x: 0, y: 1, z: 0)),
        .init(angle: 3/2 * .pi, axis: .init(x: 0, y: 1, z: 0))
    ]}}
    var wallBounceDirection : [SIMD3<Float>] {get{
    [
        .init(x: 0, y: 0, z: 1),
        .init(x: 1, y: 0, z: 0),
        .init(x: 0, y: 0, z: 1),
        .init(x: 1, y: 0, z: 0)
    ]}}
    
    var radiusPiattino : Float {get{0.017}}
    var piattinoPosition : SIMD3<Float> {get{ .init(x: 0, y: pavimentoSize.y/2 + radiusPiattino, z: wallPosition[0].z + wallSize[0].z/2 + radiusPiattino*3)}}
    var radiusDischetto : Float {get {0.01}}
    var dischettoPosition : SIMD3<Float> {get{ .init(x: 0, y: pavimentoSize.y/2 + radiusDischetto, z: wallPosition[2].z - wallSize[2].z/2 - radiusDischetto*4)}}
}

