//
//  AudioResources.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 20/07/22.
//

import Foundation
import RealityKit


class AudioResources
{
    static var collisionSound : AudioResource = try! AudioFileResource.load(named: "/Sound/hit.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var goalSound : AudioResource = try! AudioFileResource.load(named: "/Sound/score.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var goalSoundCheering : AudioResource = try! AudioFileResource.load(named: "/Sound/score-crowd.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var winGame : AudioResource = try! AudioFileResource.load(named: "/Sound/win.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var lostGame : AudioResource = try! AudioFileResource.load(named: "/Sound/lost.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var setDown : AudioResource = try! AudioFileResource.load(named: "/Sound/setdown.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var background : AudioResource = try! AudioFileResource.load(named: "/Sound/background.mp3", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
}
