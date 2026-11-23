//
//  GameCloseButton.swift
//  RagnarokGame
//
//  Created by Leon Li on 2026/5/14.
//

import SwiftUI

struct GameCloseButton: View {
    var action: () -> Void

    var body: some View {
        // basic_interface/sys_close_off.bmp
        Button(action: action) {
            ZStack {
                Capsule()
                    .frame(width: 7, height: 1.5)
                    .rotationEffect(.degrees(45))
                Capsule()
                    .frame(width: 7, height: 1.5)
                    .rotationEffect(.degrees(-45))
            }
        }
        .buttonStyle(.gameTitleBar)
        // [RagOff iPad Mod] Bigger close button that is easy to hit with a finger.
        .scaleEffect(1.8)
        .frame(width: 30, height: 24)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

#Preview {
    GameCloseButton {
        // close action
    }
    .padding()
}
