//
//  JoinOrHostView.swift
//  FingerDragMultiplayer
//
//  Created by aurelio on 19/07/22.
//

import SwiftUI


struct JoinOrHostView: View {
    @EnvironmentObject var nearbyService : NearbyService
    @State var joining : Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack
        {
            Button("Host", action:
                    {
                nearbyService.beginHosting()
            })
                .padding(EdgeInsets(
                    top: 150, leading: 0, bottom: 0, trailing: 0))
                .font(
                    .system(size: 25))
            Button("Join", action:
                    {
                joining = true
                nearbyService.beginBrowsing()
            })
                .padding(EdgeInsets(
                    top: 50, leading: 0, bottom: 100, trailing: 0))
                .font(.system(size: 25))
        }
        .sheet(isPresented: $joining, onDismiss: {presentationMode.wrappedValue.dismiss()}, content: {PeerView()})
    }
}

struct JoinOrHostView_Previews: PreviewProvider {
    static var previews: some View {
        JoinOrHostView()
    }
}
