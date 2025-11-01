//
//  Note.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import Foundation
import SwiftData

@Model
final class Note {
    var id: UUID
    var title: String
    var content: String
    var createdDate: Date
    var modifiedDate: Date

    init(title: String = "", content: String = "") {
        self.id = UUID()
        self.title = title
        self.content = content
        self.createdDate = Date()
        self.modifiedDate = Date()
    }
}
