//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Filipe Fernandes on 04/09/25.
//

import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Card.createdAt, order: .reverse) var cards: [Card]
    @State private var newPrompt: String = ""
    @State private var newAnswer: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func done() {
        dismiss()
    }
    
    func clearForm() {
        newPrompt = ""
        newAnswer = ""
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        modelContext.insert(card)
        clearForm()
    }
    
    func removeCards(at offset: IndexSet) {
        for index in offset {
            modelContext.delete(cards[index])
        }
    }
}

#Preview {
    EditCardsView()
        .modelContainer(for: Card.self)
}
