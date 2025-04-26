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
                    .frame(width: width, height:35)
                    .tint(AppColors.keyColor)
                    .background(AppColors.keyBackgroundColor)
                    .cornerRadius(8)
            }
        }.frame(width: width, height: 35)
    }

    func showTappedAnimation() {
        withAnimation(.easeIn(duration: 0.05)) {
            showMagnified = true
        }

        // Hide with animation after delay
        withAnimation(.easeOut(duration: 0.1).delay(0.14)) {
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
                .frame(width: width,height:35)
                .keyboardToolbarStyle()
                .cornerRadius(8)
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
        if key == "done" && textIsEmpty == false {
            AppColors.doneButtonColorIfTextExists
        } else {
            AppColors.toolbarButtonBackgroundColor
        }
    }

    var keyColor: Color {
        if key == "done" && textIsEmpty == false {
            Color.white
        } else {
            AppColors.keyColor
        }
    }

    var makeButtonDisabled: Bool {
        key == "done" && textIsEmpty
    }

    var body: some View {
        Button {
            onClick()
        } label: {
            Text(key)
                .font(.system(size: 18))
                .frame(width: width, height:35)
                .tint(keyColor)
                .background(backgroundColor)
                .cornerRadius(8)
        }
        .disabled(makeButtonDisabled)
    }
}

struct MeroLipiKeyboardView: View {
    let insertText: (String) -> Void
    let deleteText: () -> Void
    var needsInputModeSwitchKey: Bool = false
    var nextKeyboardAction: Selector? = nil
    let keyboardHeight: CGFloat
    let onDone: () -> Void
    @State private var currentText:String = ""
    @State private var isShowingSecondaryLayout = false


    var isCurrentTextEmpty: Bool {
        let text = currentText.trimmingCharacters(in: .whitespaces)
        return text.isEmpty
    }

    let keyboardLayoutManager = KeyboardLayoutManager.shared
    var keyboardLayout: KeyboardLayout {
        keyboardLayoutManager
            .getLayout(for: isShowingSecondaryLayout ? .secondary : .primary)
    }

    @State private var isEmojiViewPresented = false
    @State private var selectedEmoji = ""

    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                        ForEach(keyboardLayout.rows, id: \.self) { row in
                            HStack{
                                ForEach(row, id: \.self) { key in

                                    CharacterKeyView(key: key,
                                                     width: proxy.size.width * 0.08) {
                                        addText(key: key)

                                    }
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
                        }

                    HStack {
                        KeyboardToolbarWithTextView(
                            key: "१२३",
                            width: proxy.size.width * 0.10
                        ) {
                            // change the layout and show numbers in nepali
                            // along with other remaining letters as well
                            isShowingSecondaryLayout.toggle()
                            playAlphabetClickSound()
                        }.padding(.leading, 16)
                            .padding(.trailing,5)

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
                                    arrowDirection: .down
                                )
                                .onChange(of: selectedEmoji) {
                                    addText(key: selectedEmoji)
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
                            width: proxy.size.width * 0.23,
                            textIsEmpty: isCurrentTextEmpty
                        ) {
                            // done
                            onDone()
                            playAlphabetClickSound()
                        }.padding(.leading,16)
                    }
                }
                .frame(width:proxy.size.width, height: proxy.size.height)

            }
            .padding(23)
        }
        .frame(height: keyboardHeight)
    }

    func addText(key: String) {
        currentText += key
        insertText(key)
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
        playDeleteSound()
        guard currentText.count > 0 else { return }
        currentText.removeLast()
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


#Preview {
    MeroLipiKeyboardView(
        insertText: { _ in },
        deleteText: {},
        keyboardHeight: 215,
        onDone: {},
    )
}
