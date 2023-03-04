//
//  SummarizedView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct SummarizedView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Image(systemName: "arrow.down.and.line.horizontal.and.arrow.up")
                            .foregroundColor(.accentColor)
                            .dynamicTypeSize(.accessibility5)
                        
                        HStack {
                            TextField("Required", text: $model.summarizeEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                            
                            if model.summarizeEntryText.isEmpty
                            {
                                Button("Paste") {
                                    model.summarizeEntryText = UIPasteboard.general.string ?? ""
                                }
                            }
                        }
                        .padding([.leading, .trailing], 24)
                        
                        Text("Provide text")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 34)
                    }
                    
                    if model.isEmptySummarizedScreen, !model.summarizeEntryText.isEmpty
                    {
                        Text("Tap 'Generate' in the top right corner of your screen")
                            .font(.system(size: 17))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    if model.isThinking
                    {
                        VStack {
                            Text("Generating Summary...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultSummarizedScreen
                    {
                        ResultView(generatedText: model.generatedSummarizedText)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Summarize Text")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { screenToolBar }
        }
    }
    
    private var screenToolBar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    if !model.generatedSummarizedText.isEmpty
                    {
                        Button("Reset") {
                            model.summarizeEntryText = ""
                            model.generatedSummarizedText = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeSummarized()
                    let summaries = ["Space is an incredibly exciting thing that many people find fascinating.", "The force of gravity is a concept that can teach us a lot about life."]
                    model.generatedSummarizedText = summaries.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking || model.summarizeEntryText.isEmpty)
            }
        }
    }
}
