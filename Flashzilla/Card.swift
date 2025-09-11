//
//  Card.swift
//  Flashzilla
//
//  Created by Filipe Fernandes on 12/08/25.
//

import Foundation
import SwiftData

@Model
class Card: Codable, Identifiable, Equatable {
    enum CodingKeys: CodingKey {
        case id, prompt, answer, createdAt
    }
    
    var id: UUID
    var prompt: String
    var answer: String
    var createdAt: Date
    
    init(id: UUID = UUID(), prompt: String, answer: String, createdAt: Date = .now) {
        self.id = id
        self.prompt = prompt
        self.answer = answer
        self.createdAt = createdAt
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.prompt = try container.decode(String.self, forKey: .prompt)
        self.answer = try container.decode(String.self, forKey: .answer)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.prompt, forKey: .prompt)
        try container.encode(self.answer, forKey: .answer)
        try container.encode(self.createdAt, forKey: .createdAt)
        
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
