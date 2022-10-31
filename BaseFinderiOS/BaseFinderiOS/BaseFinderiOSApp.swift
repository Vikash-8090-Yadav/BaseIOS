//
//  BaseFinderiOSApp.swift
//  BaseFinderiOS
//
//  Created by Antoine Bollengier on 20.10.22.
//

import SwiftUI

@main
struct BaseFinderiOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
