//
//  MeroLipiKeyboardView.swift
//  MeroLipiKeyboard
//
//  Created by Bibek Bhujel on 14/04/2025.
//

import SwiftUI
import MCEmojiPicker


struct CharacterKeyView: View {
    let key: String
    let width: CGFloat
    let onClick: () -> Void

    @State private var showMagnified = false

    var body: some View {
        ZStack{
            if showMagnified {
                Text(key)
                    .font(.system(size: 30))
                    .frame(width: width, height:50)
                    .tint(AppColors.keyColor)
                    .background(AppColors.keyBackgroundColor)
                    .cornerRadius(8)
                    .offset(y: -40)
                    .transition(.scale.combined(with: .opacity))
            }
            Button {
                onClick()
                showTappedAnimation()
            } label: {
                Text(key)
                    .font(.system(size: 18))
                    .frame(width: width, height:45)
                    .tint(AppColors.keyColor)
                    .background(AppColors.keyBackgroundColor)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.black.opacity(0.4), lineWidth: 1),
                        alignment: .bottom
                    )
            }
        }.frame(width: width, height: 45)
    }

    func showTappedAnimation() {
        withAnimation(.easeIn(duration: 0.01)) {
            showMagnified = true
        }

        // Hide with animation after delay
        withAnimation(.easeOut(duration: 0.09).delay(0.09)) {
            showMagnified = false
        }
    }
}

struct KeyboardToolbarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundStyle(AppColors.keyColor)
            .background(AppColors.toolbarButtonBackgroundColor)
    }
}

extension View {
    func keyboardToolbarStyle() -> some View {
        modifier(KeyboardToolbarStyle())
    }
}

struct KeyboardToolbarWithImageView: View {
    let imageName: String
    let width: CGFloat
    let onClick: () -> Void
    var body: some View {
        Button {
            onClick()
        } label: {
            Image(systemName:imageName)
                .font(.system(size: 18))
                .frame(width: width,height:45)
                .keyboardToolbarStyle()
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.black.opacity(0.4), lineWidth: 1),
                    alignment: .bottom
                )
                .padding(.leading, 8)
        }
    }

}


struct KeyboardToolbarWithTextView: View {
    let key: String
    let width: CGFloat
    var textIsEmpty : Bool = true
    let onClick: () -> Void

    var backgroundColor: Color {
        if key == "done" {
            AppColors.doneButtonColorIfTextExists
        } else {
            AppColors.toolbarButtonBackgroundColor
        }
    }

    var keyColor: Color {
        if key == "done" {
            Color.white
        } else {
            AppColors.keyColor
        }
    }


    var body: some View {
        Button {
            onClick()
        } label: {
            Text(key)
                .font(.system(size: 18))
                .frame(width: width, height:45)
                .tint(keyColor)
                .background(backgroundColor)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.black.opacity(0.4), lineWidth: 0.6),
                    alignment: .bottom
                )
        }
    }
}

struct MeroLipiKeyboardView: View {
    let insertText: (String, Bool) -> Void
    let deleteText: () -> Void
    var needsInputModeSwitchKey: Bool = false
    var nextKeyboardAction: Selector? = nil
    let keyboardHeight: CGFloat
    let onDone: () -> Void
    @State private var currentText:String = ""
    @State private var isShowingNumericalLayout = false
    @State private var isShowingSecondaryLayout = false
    @State private var timer: Timer?
    var setKeyboardHeight:  (CGFloat) -> Void


    let keyboardLayoutManager = KeyboardLayoutManager.shared
    var keyboardLayout: KeyboardLayout {
        let layoutToShow: KeyboardLayoutType =
        isShowingNumericalLayout ? .numerical : (
            isShowingSecondaryLayout ? .secondary : .primary
        )
        return keyboardLayoutManager
            .getLayout(for: layoutToShow)
    }

    @State private var isEmojiViewPresented = false
    @State private var selectedEmoji: String = ""



    var matchedSuggestions: [String] {
        var prefixText = currentText
        if let lastWord = currentText.split(separator: " ").last {
            prefixText = String(lastWord)
        } else {
            prefixText = ""
        }
        return DBManager.shared.queryWords(prefix: prefixText)
    }

    @Environment(\.verticalSizeClass) var verticalSizeClass

    var isLandscapeMode: Bool {
        verticalSizeClass == .compact
    }
    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    if !isLandscapeMode {
                        HStack(spacing: 50){
                            ForEach(matchedSuggestions.prefix(3), id: \.self) { suggestion in
                                Button {
                                    onSuggestionClicked(suggestion: suggestion)
                                    insertText(suggestion, true)
                                }label: {
                                    Text(suggestion)
                                        .tint(AppColors.keyColor)
                                }
                            }
                        }
                        .frame(height: 35)
                    }
                    ForEach(keyboardLayout.rows, id: \.self) { row in
                        HStack{
                            ForEach(row, id: \.self) { key in

                                CharacterKeyView(key: key,
                                                 width: proxy.size.width * 0.08) {
                                    addText(key: key)

                                }.padding(.bottom, 1)
                            }
                        }
                    }



                    HStack{
                        ForEach(
                            keyboardLayout.secondLastRow,
                            id: \.self
                        ) { key in
                            CharacterKeyView(key: key,
                                             width: proxy.size.width * 0.08
                            ) {
                                addText(key: key)
                            }
                        }
                        KeyboardToolbarWithImageView(
                            imageName:"delete.backward",
                            width: proxy.size.width * 0.165
                        ) {
                            removeText()
                        }
                        .onLongPressGesture(
                            minimumDuration: 0.1,
                            pressing: { isPressing in
                                if isPressing {
                                    // Start a new timer only if one isn't already running
                                    if timer == nil {
                                        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                            removeText()
                                        }
                                    }
                                } else {
                                    // Stop the timer when the user releases the button
                                    timer?.invalidate()
                                    timer = nil // Reset the timer variable
                                }
                            },
                            perform: {} // Empty, as the action is handled by the timer
                        )
                    }

                    HStack {
                        KeyboardToolbarWithImageView(
                            imageName: isShowingSecondaryLayout ? "arrowshape.up.fill": "arrowshape.up",
                            width: proxy.size.width * 0.10,
                            onClick:  {
                                playAlphabetClickSound()
                                isShowingSecondaryLayout.toggle()
                            }
                        )
                        KeyboardToolbarWithTextView(
                            key: isShowingNumericalLayout ? "कख" : "१२३",
                            width: proxy.size.width * 0.10
                        ) {
                            // change the layout and show numbers in nepali
                            // along with other remaining letters as well
                            isShowingNumericalLayout.toggle()
                            playAlphabetClickSound()
                        }

                        if needsInputModeSwitchKey && nextKeyboardAction != nil {
                            SelectKeyboardToolbarButtonView(
                                action: nextKeyboardAction!,
                                imageName: "globe",
                                width: proxy.size.width * 0.10
                            )
                        } else {
                            // show default emoji view
                            KeyboardToolbarWithImageView(imageName: "face.smiling", width: proxy.size.width * 0.10) {
                                playAlphabetClickSound()
                                isEmojiViewPresented.toggle()
                            }
                            .emojiPicker(
                                isPresented: $isEmojiViewPresented,
                                selectedEmoji: $selectedEmoji,
                                arrowDirection: .down,
                                customHeight: 400.0,
                                horizontalInset: .zero,
                                isDismissAfterChoosing: false,
                                selectedEmojiCategoryTintColor: .systemBlue,
                                feedBackGeneratorStyle: .light
                            )
                            .onChange(of: selectedEmoji) { oldValue, newValue in
                                if !newValue.isEmpty {
                                    addText(key: newValue)
                                }

                                DispatchQueue.main.async {
                                    self.selectedEmoji = ""
                                }
                            }
                            .onChange(of: isEmojiViewPresented) {
                                DispatchQueue.main.async {
                                    if isEmojiViewPresented {
                                        setKeyboardHeight(350)
                                    } else {
                                        setKeyboardHeight(keyboardHeight)
                                    }
                                }
                            }
                        }
                        KeyboardToolbarWithTextView(key: "space",width: proxy.size.width * 0.38) {
                            addText(key: " ")
                        }
                        CharacterKeyView(key: "।", width: proxy.size.width * 0.08) {
                            addText(key:"।")
                        }
                        KeyboardToolbarWithTextView(
                            key: "done",
                            width: proxy.size.width * 0.17
                        ) {
                            // done
                            onDone()
                            playAlphabetClickSound()
                        }.padding(.leading,10)
                    }
                }
                .frame(width:proxy.size.width, height: proxy.size.height)
                .onChange(of: isLandscapeMode) {
                    if isLandscapeMode {
                        setKeyboardHeight(265)
                    } else {
                        setKeyboardHeight(320)
                    }
                }
            }
            .padding(23)
        }
        .frame(height: keyboardHeight)
    }

    func addText(key: String) {
        currentText += key
        insertText(key, false)
        if key == " " {
            playToolbarSound()
        } else {
            playAlphabetClickSound()
        }
    }

    func playAlphabetClickSound() {
        KeyboardSoundManager.shared
            .playSound(for: .alphabet)
    }

    func playDeleteSound() {
        KeyboardSoundManager.shared
            .playSound(for: .delete)
    }

    func playToolbarSound() {
        KeyboardSoundManager.shared.playSound(for: .toolButton)
    }

    func removeText() {
        deleteText()
        guard currentText.count > 0 else { return }
        playDeleteSound()
        currentText.removeLast()
    }


    func onSuggestionClicked(suggestion: String) {
        var wordsArray = currentText.trimmingCharacters(in: .whitespaces).split(
            separator: " "
        )
        if wordsArray.count == 0 {
            currentText = suggestion
        } else {
            let lastIndex = wordsArray.count - 1
            wordsArray[lastIndex] = Substring(suggestion)
            var combinedText = ""
            for i in wordsArray.indices {
                    combinedText += wordsArray[i]
                    combinedText += " "
            }
            currentText = combinedText
        }
    }

    struct SelectKeyboardToolbarButtonView: UIViewRepresentable {
        let action: Selector
        let imageName: String
        let width: CGFloat
        let height: CGFloat = 44

        func makeUIView(context: Context) -> UIButton {
            var config = UIButton.Configuration.filled()
            config.image = UIImage(
                systemName: imageName)
            config.baseForegroundColor = UIColor(AppColors.keyColor)
            config.baseBackgroundColor = UIColor(AppColors.toolbarButtonBackgroundColor)
            config.cornerStyle = .fixed
            config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 6, bottom: 7, trailing: 6)

            let button = UIButton(configuration: config)
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)


            button.layer.cornerRadius = 8
            button.clipsToBounds = true

            button.addTarget(nil, action: action, for: .allTouchEvents)
            return button
        }

        func updateUIView(_ button: UIButton, context: Context) {}
    }
}

#Preview {

    MeroLipiKeyboardView(
        insertText: {_ , _ in },
        deleteText: {} ,
        keyboardHeight: 275,
        onDone: {},
        setKeyboardHeight: { _ in }
    )
}
