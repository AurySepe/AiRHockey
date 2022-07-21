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
    @State var single: String = "Single Player"
    @State var multi: String = "Multi Player"
    @State var lang: String = "Language"
    @State var music: String = "Music"
    @ObservedObject var musicM = musicModel()
    
    var body: some View {
        NavigationView {
            
            VStack(content: {
                Text("Air Hockey AR")
                    .bold()
                    .font(
                        .system(size: 50))
                Button(MenuView.LANGUAGESDICTS[language]!["single"]!, action:{
                    showingSingleView.toggle()})
                .padding(EdgeInsets(
                    top: 150, leading: 0, bottom: 0, trailing: 0))
                .font(
                    .system(size: 25))
                Button(self.multi, action:{
                    showingMultiView.toggle()})
                .padding(EdgeInsets(
                    top: 50, leading: 0, bottom: 100, trailing: 0))
                .font(.system(size: 25))
            })
            
            .navigationBarItems(trailing: Menu() {
                Menu(self.lang) {
                    Button("English", action: {
                    language = "en"})
                    Button("Italiano", action: {
                        language = "it"})
                }
                Toggle(isOn: Binding<Bool>(
                    get: { self.musicM.mOn },
                    set: { self.musicM.mOn = $0; self.doMusic() })) {
                        Text(self.music)
                    }.onAppear(perform: self.startBackgroundMusic)
            } label:{
                Label(" ", systemImage: "gear")
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaleEffect(2, anchor: .center)
            }
            )
        }
        .onAppear(perform: self.startBackgroundMusic)
        .sheet(isPresented: $showingSingleView, onDismiss: {}, content: {})
        .sheet(isPresented: $showingMultiView, onDismiss: {}, content: {JoinOrHostView()})
    }
    
    func lang(selected:String){
        switch selected{
        case "it":
            single = "Giocatore Singolo"
            multi = "Multi Giocatore"
            lang = "Lingua"
            music = "Musica"
        default:
            single = "Single Player"
            multi = "Multi Player"
            lang = "Language"
            music = "Music"
        }
    }
    
    func single(language : String) -> String
    {
        if language == "en"
        {
            return "Single Player"
            
        }
        else
        {
            return "Giocatore Singolo"
        }
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
        "multi":"Multi Player"

    ]
    static let WORDSIT = [
        "single":"Giocatore Singolo",
        "multi":"Giocatore Multiplo"

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

