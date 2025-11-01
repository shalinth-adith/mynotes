//
//  NoteDetailView.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI

struct NoteDetailView: View {
    @Bindable var note: Note
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Field?
    @State private var isTyping = false
    @State private var showSavedIndicator = false
    @State private var keyboardHeight: CGFloat = 0

    enum Field {
        case title, content
    }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header with metadata
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Last edited")
                            .font(.caption)
                            .foregroundColor(Theme.tertiaryText)
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 10))
                            Text(note.modifiedDate, style: .relative)
                                .font(.caption)
                        }
                        .foregroundColor(Theme.secondaryText)
                    }

                    Spacer()

                    // Typing indicator
                    if isTyping {
                        HStack(spacing: 6) {
                            TypingIndicator()
                            Text("Editing")
                                .font(.caption)
                                .foregroundColor(Theme.secondaryText)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }

                    // Saved indicator
                    if showSavedIndicator {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Saved")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Theme.secondaryBackground.opacity(0.5))

                // Title TextField
                TextField("Title", text: $note.title, axis: .vertical)
                    .font(.title2.bold())
                    .foregroundColor(Theme.primaryText)
                    .padding(.horizontal)
                    .padding(.top)
                    .focused($isFocused, equals: .title)
                    .submitLabel(.next)
                    .onSubmit {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isFocused = .content
                        }
                    }

                Divider()
                    .overlay(Theme.separator)
                    .padding(.horizontal)
                    .padding(.top, 8)

                // Content TextEditor
                TextEditor(text: $note.content)
                    .font(.body)
                    .foregroundColor(Theme.primaryText)
                    .padding(.horizontal)
                    .focused($isFocused, equals: .content)
                    .scrollContentBackground(.hidden)
                    .background(Theme.background)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        isFocused = nil
                    }
                    HapticManager.shared.selection()
                }
                .buttonStyle(BouncyButtonStyle())
            }
        }
        .onChange(of: note.title) { _, _ in
            handleTextChange()
        }
        .onChange(of: note.content) { _, _ in
            handleTextChange()
        }
        .onChange(of: isFocused) { _, newValue in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isTyping = newValue != nil
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.3)) {
                if note.title.isEmpty && note.content.isEmpty {
                    isFocused = .title
                }
            }
        }
    }

    private func updateModifiedDate() {
        note.modifiedDate = Date()
    }

    private func handleTextChange() {
        updateModifiedDate()

        // Show saved indicator briefly
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            showSavedIndicator = true
        }

        // Hide it after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                showSavedIndicator = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(note: Note(title: "Sample Note", content: "This is a sample note content"))
    }
}
