//
//  AudioResources.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 20/07/22.
//

import Foundation


class AudioResources
{
    static var collisionSound : AudioResource = try! AudioFileResource.load(named: "/hit.wav", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
    static var goalSound : AudioResource = try! AudioFileResource.load(named: "/goal.wav", in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
}
