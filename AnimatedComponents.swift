//
//  AnimatedComponents.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI
import UIKit

// MARK: - Floating Action Button
struct FloatingActionButton: View {
    let action: () -> Void
    @State private var isPressed = false
    @State private var rotation: Double = 0

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
                rotation += 90
            }

            // Haptic feedback
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }

            action()
        }) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                    .shadow(color: Color.blue.opacity(0.4), radius: isPressed ? 5 : 15, x: 0, y: isPressed ? 2 : 8)

                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(rotation))
            }
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
    }
}

// MARK: - Animated Empty State
struct AnimatedEmptyState: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Pulsing background circles
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 140, height: 140)
                    .scaleEffect(isAnimating ? 1.1 : 0.9)

                Circle()
                    .fill(Color.blue.opacity(0.05))
                    .frame(width: 160, height: 160)
                    .scaleEffect(isAnimating ? 0.9 : 1.1)

                // Animated icon
                Image(systemName: "note.text")
                    .font(.system(size: 50))
                    .foregroundColor(Theme.accent)
                    .rotationEffect(.degrees(isAnimating ? -5 : 5))
            }
            .animation(
                Animation.easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )

            Text("No Notes")
                .font(.title2.bold())
                .foregroundColor(Theme.primaryText)

            Text("Tap the + button to create your first note")
                .font(.subheadline)
                .foregroundColor(Theme.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Animated Note Card
struct AnimatedNoteCard<Content: View>: View {
    let content: Content
    @State private var isVisible = false
    let delay: Double

    init(delay: Double = 0, @ViewBuilder content: () -> Content) {
        self.delay = delay
        self.content = content()
    }

    var body: some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(delay)) {
                    isVisible = true
                }
            }
    }
}

// MARK: - Shimmer Effect
struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        Color.white.opacity(0.3),
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 300
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerEffect())
    }
}

// MARK: - Bouncy Button Style
struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Success Checkmark Animation
struct SuccessCheckmark: View {
    @State private var trimEnd: CGFloat = 0
    @State private var scale: CGFloat = 0
    @State private var rotation: Double = -45

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 50, height: 50)
                .scaleEffect(scale)

            Image(systemName: "checkmark")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.green)
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                scale = 1
                rotation = 0
            }
        }
    }
}

// MARK: - Typing Indicator
struct TypingIndicator: View {
    @State private var animatingDots = [false, false, false]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Theme.accent)
                    .frame(width: 6, height: 6)
                    .scaleEffect(animatingDots[index] ? 1.2 : 0.8)
                    .opacity(animatingDots[index] ? 1 : 0.5)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: animatingDots[index]
                    )
            }
        }
        .onAppear {
            for i in 0..<3 {
                animatingDots[i] = true
            }
        }
    }
}

// MARK: - Haptic Manager
class HapticManager {
    static let shared = HapticManager()

    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
