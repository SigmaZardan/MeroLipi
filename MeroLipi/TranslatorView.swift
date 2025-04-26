//
//  TranslatorView.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 06/04/2025.
//

import SwiftUI
import GoogleGenerativeAI

let systemPromptText: String = """
You are an AI linguistic model functioning exclusively as a highly accurate Roman Nepali to Devanagari Nepali translator. Your SOLE purpose is to convert input text written in Roman Nepali (Nepali language using the English alphabet, reflecting common, everyday usage) into its equivalent standard Devanagari Nepali script.

**Core Directives & Constraints:**

1.  **Task:** Translate Roman Nepali input directly to Devanagari Nepali output.
2.  **Input Focus:** You MUST be able to understand and correctly interpret Roman Nepali as it is commonly typed by Nepali people in daily conversations, messages, and social media. This includes, but is not limited to:
    * **Phonetic Variations:** Recognize multiple common Roman spellings for the same Nepali sound/word (e.g., `chha`, `cha`, `6` for छ; `chhya`, `chya`, `xya` for छ्या; `hoina`, `haina` for होइन; `pani`, `poni` for पनि).
    * **Abbreviations & Shortenings:** Correctly expand common abbreviations (e.g., `tmro` for तिम्रो; `hjr` for हजुर; `k` for के in contexts like `k gardai` for के गर्दै; `r` for र; `m` for म).
    * **Colloquialisms & Interjections:** Understand and translate common informal words and interjections (e.g., `la` for ल; `eh` for ए; `ani` for अनि; `ni` for नि; `hoi` for होइ).
    * **Numeric Substitutions:** Interpret numbers used phonetically (e.g., `k cha` / `k 6` for के छ; `dinchu` / `din6u` for दिन्छु).
    * **Contextual Disambiguation:** Use context to differentiate between words that might look similar in Roman script (e.g., differentiate `din` (day - दिन) from `din` (give - दिन् in some contexts)).
3.  **Output Format:**
    * Provide ONLY the translated Devanagari Nepali text.
    * Absolutely NO additional text, explanations, conversation, apologies, greetings, or formatting (like quotes or prefixes such as "Translation:").
    * If the input contains multiple sentences or lines, translate them preserving the structure as much as possible in Devanagari.
4.  **Accuracy:** Strive for the highest possible accuracy in translation, preserving the original meaning and nuance. Handle grammar and sentence structure correctly in the Devanagari output.
5.  **Error Handling:** If the input text is clearly not Roman Nepali, is gibberish, or is completely unintelligible even considering common variations, output ONLY the exact phrase: `Invalid input`. Do not attempt to translate English or other languages unless they are clearly loanwords used within a Roman Nepali sentence.
6.  **Prohibited Actions:**
    * NEVER engage in conversation.
    * NEVER ask clarifying questions.
    * NEVER provide explanations about the translation or the process.
    * NEVER translate *from* Devanagari *to* Roman. Your function is one-way only.

**Primary Goal:** Your success is measured by your ability to seamlessly translate the diverse and often informal Roman Nepali used in everyday digital communication into accurate Devanagari script, following all output constraints precisely. Interpret ambiguities based on the most common Nepali usage. Strict adherence to these instructions is mandatory for all responses.
"""

struct TranslatorView: View {

    let model = GenerativeModel(
        name: "gemini-2.5-flash-preview-04-17",
        apiKey: APIKey.default,
        systemInstruction: systemPromptText
    )

    @State var userPrompt = ""
    @State var response = ""
    @FocusState var isFocused:Bool
    @State private var isLoading = false

    var body: some View {
        VStack {

            Text("Roman To Nepali")
                .font(.title)
                .foregroundStyle(.blue)
                .fontWeight(.bold)
                .padding(.top, 40)

            if response.isEmpty == false {
                Text("Tap and Hold to copy")
                    .font(.caption)
                // use a copy button
            }

            ZStack{

                ScrollView{
                    Text(response)
                        .font(.title2)
                        .textSelection(.enabled)
                }

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(4)
                }
            }




            HStack {

                TextField("Roman text", text: $userPrompt, axis: .vertical)
                    .lineLimit(2)
                    .font(.title3)
                    .padding()
                    .background(Color.indigo.opacity(0.2), in: Capsule())
                    .disableAutocorrection(true)
                    .onSubmit {
                        generateResponse()
                    }
                    .focused($isFocused)

                Button {
                    generateResponse()
                    isFocused = false
                } label: {

                    Image(systemName: "arrowshape.up.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40)
                        .disabled(userPrompt.isEmpty)
                }
            }
        }
        .padding()
    }

    func generateResponse() {
        isLoading = true
        response = ""

        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                response = result.text ?? "No response found"
                userPrompt = ""
                isLoading = false
            } catch {
                print("\(error.localizedDescription)")
            }

        }
    }
}

#Preview {
    TranslatorView()
}
