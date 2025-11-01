//
//  mynotesApp.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI
import SwiftData

@main
struct mynotesApp: App {
    var body: some Scene {
        WindowGroup {
            NotesListView()
        }
        .modelContainer(for: Note.self)
    }
}
