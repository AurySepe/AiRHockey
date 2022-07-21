//
//  ContentView.swift
//  AirHockeyAR
//
//  Created by Apple on 15/07/22.
//

import SwiftUI
import Foundation
import AVFoundation

struct MenuView: View {
    @State var showingSingleView : Bool = false
    @State var showingMultiView : Bool = false
    @State var language = "en"
    @ObservedObject var musicM = musicModel()
    
    var body: some View {
        
        NavigationView {
            VStack(content: {
                Image(uiImage: UIImage(named: "logo.png")!)
                    .resizable()
                    .frame(width: 300, height: 150, alignment: .center)
                Button(MenuView.LANGUAGESDICTS[language]!["single"]!, action:{
                    showingSingleView.toggle()})
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .padding(EdgeInsets(
                    top: 150, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 25))
                Button(MenuView.LANGUAGESDICTS[language]!["multi"]!, action:{
                    showingMultiView.toggle()})
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .padding(EdgeInsets(
                    top: 50, leading: 0, bottom: 100, trailing: 0))
                .font(.system(size: 25))
            })

            
            .navigationBarItems(trailing: Menu() {
                Menu(MenuView.LANGUAGESDICTS[language]!["listLang"]!) {
                    Button("English", action: {
                        language = "en"})
                    Button("Italiano", action: {
                        language = "it"})
                }
                Toggle(isOn: Binding<Bool>(
                    get: { self.musicM.mOn },
                    set: { self.musicM.mOn = $0; self.doMusic() })) {
                        Text(MenuView.LANGUAGESDICTS[language]!["music"]!)
                    }.onAppear(perform: self.startBackgroundMusic)
            } label:{
                Label(" ", systemImage: "gear")
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaleEffect(2, anchor: .center)
            }
            )
            
        }
        .onAppear(perform: self.startBackgroundMusic)
        .sheet(isPresented: $showingSingleView, onDismiss: {}, content:
                {VStack(content: {
            Image(systemName:"exclamationmark.triangle")
                .frame(width: 50, height: 50, alignment: .center)
                .scaleEffect(3, anchor: .center)
                .foregroundColor(.yellow)
            Text(MenuView.LANGUAGESDICTS[language]!["working"]!)})})
        .sheet(isPresented: $showingMultiView, onDismiss: {}, content: {JoinOrHostView(language: $language)})
    }
    
    func startBackgroundMusic() {
        if self.musicM.mOn {
            self.musicM.playSoundBand(sound: "background", type: "mp3")
        }
    }
    
    func doMusic() {
        if self.musicM.mOn {
            self.musicM.playSoundBand(sound: "background", type: "mp3")
        } else {
            self.musicM.audioPlayerBand?.pause()
        }
    }
    
    static let WORDSEN = [
        "single":"Single Player",
        "multi":"Multi Player",
        "listLang":"Language",
        "music":"Music",
        "working":"Work in progress"
    ]
    
    static let WORDSIT = [
        "single":"Giocatore Singolo",
        "multi":"Multi Giocatore",
        "listLang":"Lingua",
        "music":"Musica",
        "working":"Lavori in corso"
    ]
    
    static var LANGUAGESDICTS = ["en" : WORDSEN,"it" : WORDSIT]
}

class musicModel: ObservableObject {
    var audioPlayerBand: AVAudioPlayer?
    
    @Published var mOn: Bool = UserDefaults.standard.bool(forKey: "mOn") {
        didSet {
            UserDefaults.standard.set(self.mOn, forKey: "mOn")
        }
    }
    func pauseMusicBand() {
        UserDefaults.standard.set(false, forKey: "mOn")
        audioPlayerBand?.pause()
    }
    func setVolume(volume: Float) {
        audioPlayerBand?.volume = volume
    }
    func playSoundBand(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayerBand = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayerBand?.numberOfLoops =  -1
                audioPlayerBand?.play()
            } catch {
                print("ERROR: Could not find sound file!")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .previewInterfaceOrientation(.portrait)
    }
}

