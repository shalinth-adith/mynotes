//
//  NotesListView.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI
import SwiftData

struct NotesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var systemColorScheme
    @StateObject private var themeManager = ThemeManager.shared
    @Query(sort: \Note.modifiedDate, order: .reverse) private var notes: [Note]
    @State private var searchText = ""
    @State private var showingNewNote = false
    @State private var showingSettings = false
    @Namespace private var animation

    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) ||
                note.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(Array(filteredNotes.enumerated()), id: \.element.id) { index, note in
                        AnimatedNoteCard(delay: Double(index) * 0.05) {
                            NavigationLink(destination: NoteDetailView(note: note)) {
                                NoteRowView(note: note)
                            }
                        }
                        .listRowBackground(Theme.secondaryGroupedBackground)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                    }
                    .onDelete(perform: deleteNotes)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Theme.groupedBackground)
                .navigationTitle("Notes")
                .searchable(text: $searchText, prompt: "Search notes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            HapticManager.shared.selection()
                            showingSettings = true
                        }) {
                            Label("Settings", systemImage: "gear")
                        }
                        .buttonStyle(BouncyButtonStyle())
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .buttonStyle(BouncyButtonStyle())
                    }
                }
                .overlay {
                    if notes.isEmpty {
                        AnimatedEmptyState()
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsView()
                }

                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton(action: createNewNote)
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .preferredColorScheme(themeManager.colorScheme)
    }

    private func createNewNote() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            let newNote = Note()
            modelContext.insert(newNote)
            showingNewNote = true
        }
        HapticManager.shared.impact(.medium)
    }

    private func deleteNotes(at offsets: IndexSet) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            for index in offsets {
                let note = filteredNotes[index]
                modelContext.delete(note)
            }
        }
        HapticManager.shared.notification(.success)
    }
}

struct NoteRowView: View {
    let note: Note
    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 12) {
            // Icon with gradient background
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Theme.accent.opacity(0.2),
                                Theme.accent.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)

                Image(systemName: note.title.isEmpty ? "doc.text" : "doc.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Theme.accent)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(note.title.isEmpty ? "New Note" : note.title)
                    .font(.headline)
                    .foregroundColor(note.title.isEmpty ? Theme.secondaryText : Theme.primaryText)
                    .lineLimit(1)

                if !note.content.isEmpty {
                    Text(note.content)
                        .font(.subheadline)
                        .foregroundColor(Theme.secondaryText)
                        .lineLimit(2)
                }

                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                    Text(note.modifiedDate, style: .relative)
                        .font(.caption)
                }
                .foregroundColor(Theme.tertiaryText)
            }
        }
        .padding(.vertical, 8)
        .scaleEffect(isPressed ? 0.98 : 1.0)
    }
}

#Preview {
    NotesListView()
        .modelContainer(for: Note.self, inMemory: true)
}
