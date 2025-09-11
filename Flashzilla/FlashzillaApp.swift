//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Filipe Fernandes on 29/07/25.
//

import SwiftData
import SwiftUI

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
