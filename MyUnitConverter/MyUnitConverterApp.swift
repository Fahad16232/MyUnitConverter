//
//  MyUnitConverterApp.swift
//  MyUnitConverter
//
//  Created by Dev Reptech on 07/03/2024.
//

import SwiftUI

@main
struct MyUnitConverterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
