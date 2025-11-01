//
//  SettingsView.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var themeManager = ThemeManager.shared
    @State private var selectedAppearance: AppearanceOption = .automatic

    enum AppearanceOption: String, CaseIterable {
        case automatic = "Automatic"
        case light = "Light"
        case dark = "Dark"

        var icon: String {
            switch self {
            case .automatic: return "circle.lefthalf.filled"
            case .light: return "sun.max.fill"
            case .dark: return "moon.fill"
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(AppearanceOption.allCases, id: \.self) { option in
                        Button(action: {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                selectedAppearance = option
                            }
                            updateTheme(for: option)
                            HapticManager.shared.impact(.light)
                        }) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Theme.accent.opacity(0.15))
                                        .frame(width: 36, height: 36)

                                    Image(systemName: option.icon)
                                        .foregroundColor(Theme.accent)
                                        .font(.system(size: 16))
                                }

                                Text(option.rawValue)
                                    .foregroundColor(Theme.primaryText)
                                    .font(.body)

                                Spacer()

                                if selectedAppearance == option {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Theme.accent)
                                        .font(.system(size: 20))
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(BouncyButtonStyle())
                        .listRowBackground(Theme.secondaryGroupedBackground)
                    }
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Automatic will match your system settings")
                }

                Section {
                    HStack {
                        Text("Version")
                            .foregroundColor(Theme.primaryText)
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(Theme.secondaryText)
                    }
                    .listRowBackground(Theme.secondaryGroupedBackground)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Theme.groupedBackground)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        HapticManager.shared.selection()
                        dismiss()
                    }
                    .buttonStyle(BouncyButtonStyle())
                }
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            loadCurrentAppearance()
        }
    }

    private func loadCurrentAppearance() {
        if let scheme = themeManager.colorScheme {
            selectedAppearance = scheme == .light ? .light : .dark
        } else {
            selectedAppearance = .automatic
        }
    }

    private func updateTheme(for option: AppearanceOption) {
        switch option {
        case .automatic:
            themeManager.setColorScheme(nil)
        case .light:
            themeManager.setColorScheme(.light)
        case .dark:
            themeManager.setColorScheme(.dark)
        }
    }
}

#Preview {
    SettingsView()
}
