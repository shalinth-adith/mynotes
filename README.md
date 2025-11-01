# MyNotes - Modern iOS Notes App                                                   │
│                                                                                    │
│ A beautiful, feature-rich notes application for iOS built with SwiftUI, featuring  │
│ dark mode support, smooth animations, and persistent storage using SwiftData.      │
│                                                                                    │
│ ## Features                                                                        │
│                                                                                    │
│ ### Core Functionality                                                             │
│ - **Create & Edit Notes** - Quickly jot down ideas with an intuitive text editor   │
│ - **Persistent Storage** - All notes are automatically saved using SwiftData       │
│ - **Search Functionality** - Find notes instantly by searching title or content    │
│ - **Delete Notes** - Remove notes with swipe-to-delete or edit mode                │
│ - **Auto-Save** - Changes are saved automatically as you type                      │
│                                                                                    │
│ ### Visual Design                                                                  │
│ - **Dark Mode Support** - Beautiful adaptive theming for light and dark modes      │
│ - **Custom Theme Engine** - Switch between Automatic, Light, or Dark appearance    │
│ - **Smooth Animations** - Spring-based animations throughout the app               │
│ - **Floating Action Button** - Quick access to create new notes with animated      │
│ feedback                                                                           │
│ - **Empty State** - Engaging animated placeholder when no notes exist              │
│ - **Live Typing Indicator** - Visual feedback while editing                        │
│ - **Gradient Accents** - Modern UI with gradient backgrounds and icons             │
│                                                                                    │
│ ### User Experience                                                                │
│ - **Haptic Feedback** - Tactile responses for button taps and actions              │
│ - **Staggered List Animations** - Notes appear with elegant entrance effects       │
│ - **Saved Indicator** - Visual confirmation when changes are saved                 │
│ - **Bouncy Interactions** - Playful spring animations on buttons                   │
│ - **Last Modified Time** - Relative timestamps for each note                       │
│ - **Settings Panel** - Customize app appearance with a sleek settings screen       │
│                                                                                    │
│ ## Screenshots                                                                     │
│                                                                                    │
│ > Add screenshots of your app here                                                 │
│                                                                                    │
│ ## Technologies Used                                                               │
│                                                                                    │
│ - **SwiftUI** - Modern declarative UI framework                                    │
│ - **SwiftData** - Apple's latest data persistence framework                        │
│ - **Combine** - Reactive programming for theme management                          │
│ - **UIKit** - Haptic feedback and system colors                                    │
│ - **Swift 5.9+** - Latest Swift language features                                  │
│                                                                                    │
│ ## Requirements                                                                    │
│                                                                                    │
│ - iOS 17.0+                                                                        │
│ - Xcode 15.0+                                                                      │
│ - macOS 14.0+ (for development)                                                    │
│                                                                                    │
│ ## Installation                                                                    │
│                                                                                    │
│ 1. Clone the repository:                                                           │
│ ```bash                                                                            │
│ git clone https://github.com/shalinth-adith/mynotes.git                            │
│ ```                                                                                │
│                                                                                    │
│ 2. Open the project in Xcode:                                                      │
│ ```bash                                                                            │
│ cd mynotes                                                                         │
│ open mynotes.xcodeproj                                                             │
│ ```                                                                                │
│                                                                                    │
│ 3. Select your target device or simulator                                          │
│                                                                                    │
│ 4. Build and run the project (⌘R)                                                  │
│                                                                                    │
│ ## Project Structure                                                               │
│                                                                                    │
│ ```                                                                                │
│ mynotes/                                                                           │
│ ├── mynotes/                                                                       │
│ │   ├── mynotesApp.swift           # App entry point with SwiftData configuration  │
│ │   ├── Note.swift                 # SwiftData model for notes                     │
│ │   ├── NotesListView.swift        # Main list view with search and FAB            │
│ │   ├── NoteDetailView.swift       # Note editing interface                        │
│ │   ├── SettingsView.swift         # Theme and appearance settings                 │
│ │   ├── Theme.swift                # Color scheme manager and theme definitions    │
│ │   ├── AnimatedComponents.swift   # Reusable animated UI components               │
│ │   └── Assets.xcassets/          # App icons and assets                           │
│ ├── mynotesTests/                  # Unit tests                                    │
│ ├── mynotesUITests/                # UI tests                                      │
│ └── README.md                                                                      │
│ ```                                                                                │
│                                                                                    │
│ ## Usage                                                                           │
│                                                                                    │
│ ### Creating a Note                                                                │
│ 1. Tap the floating blue '+' button in the bottom-right corner                     │
│ 2. Enter a title and start typing your content                                     │
│ 3. Changes are saved automatically                                                 │
│                                                                                    │
│ ### Searching Notes                                                                │
│ 1. Pull down on the notes list to reveal the search bar                            │
│ 2. Type to filter notes by title or content                                        │
│ 3. Search is case-insensitive and instant                                          │
│                                                                                    │
│ ### Deleting Notes                                                                 │
│ - **Swipe left** on any note and tap Delete                                        │
│ - **Or** tap Edit button → select notes → tap Delete                               │
│                                                                                    │
│ ### Changing Theme                                                                 │
│ 1. Tap the gear icon in the top-right corner                                       │
│ 2. Select your preferred appearance:                                               │
│    - **Automatic** - Matches system settings                                       │
│    - **Light** - Always light mode                                                 │
│    - **Dark** - Always dark mode                                                   │
│ 3. Changes apply immediately                                                       │
│                                                                                    │
│ ## Key Components                                                                  │
│                                                                                    │
│ ### SwiftData Model                                                                │
│ The `Note` model uses SwiftData's `@Model` macro for automatic persistence:        │
│ - UUID-based identification                                                        │
│ - Title and content fields                                                         │
│ - Created and modified timestamps                                                  │
│                                                                                    │
│ ### Theme System                                                                   │
│ Adaptive color system that responds to system appearance:                          │
│ - Dynamic colors from UIKit for perfect integration                                │
│ - Persistent theme preferences                                                     │
│ - ObservableObject pattern for reactive updates                                    │
│                                                                                    │
│ ### Animation Components                                                           │
│ - **FloatingActionButton** - Gradient button with rotation and haptics             │
│ - **AnimatedEmptyState** - Pulsing circles with rocking icon                       │
│ - **AnimatedNoteCard** - Staggered entrance animations                             │
│ - **TypingIndicator** - Three-dot animation for live editing                       │
│ - **HapticManager** - Centralized haptic feedback system                           │
│                                                                                    │
│ ## Future Enhancements                                                             │
│                                                                                    │
│ - [ ] Note categories/folders                                                      │
│ - [ ] Rich text formatting (bold, italic, lists)                                   │
│ - [ ] Image attachments                                                            │
│ - [ ] Note sharing via Share Sheet                                                 │
│ - [ ] iCloud sync across devices                                                   │
│ - [ ] Note pinning                                                                 │
│ - [ ] Color-coded notes                                                            │
│ - [ ] Note templates                                                               │
│ - [ ] Voice-to-text dictation                                                      │
│ - [ ] Markdown support                                                             │
│ - [ ] Export notes (PDF, TXT)                                                      │
│ - [ ] Lock notes with Face ID/Touch ID                                             │
│ - [ ] Widget support                                                               │
│                                                                                    │
│ ## Architecture                                                                    │
│                                                                                    │
│ The app follows SwiftUI best practices:                                            │
│ - **MVVM Pattern** - Views observe SwiftData models                                │
│ - **Unidirectional Data Flow** - State changes flow down, actions flow up          │
│ - **Single Source of Truth** - SwiftData as the central data store                 │
│ - **Composition** - Reusable components and modifiers                              │
│                                                                                    │
│ ## Performance                                                                     │
│                                                                                    │
│ - Lazy loading of note list                                                        │
│ - Efficient SwiftData queries with @Query property wrapper                         │
│ - Optimized animations with spring physics                                         │
│ - Minimal re-renders with proper state management                                  │
│                                                                                    │
│ ## Accessibility                                                                   │
│                                                                                    │
│ - Dynamic Type support for text scaling                                            │
│ - VoiceOver-friendly labels                                                        │
│ - High contrast color support via system colors                                    │
│ - Keyboard navigation support                                                      │
│                                                                                    │
│ ## License                                                                         │
│                                                                                    │
│ This project is available for personal and educational use.                        │
│                                                                                    │
│ ## Author                                                                          │
│                                                                                    │
│ **Shalinth Adithyan**                                                              │
│ - GitHub: [@shalinth-adith](https://github.com/shalinth-adith)                     │
│                                                                                    │
│ ## Acknowledgments                                                                 │
│                                                                                    │
│ Built with modern iOS development practices and Apple's latest frameworks. Special │
│  thanks to the SwiftUI and iOS development community for inspiration and best      │
│ practices.                                                                         │
│                                                                                    │
│ ---                                                                                │
│                                                                                    │
│ **Note**: This app requires iOS 17+ to take advantage of SwiftData and the latest  │
│ SwiftUI features.  
