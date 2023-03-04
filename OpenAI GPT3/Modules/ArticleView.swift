//
//  ArticleView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct ArticleView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Image(systemName: "book.closed")
                            .foregroundColor(.accentColor)
                            .dynamicTypeSize(.accessibility5)
                        
                        HStack {
                            TextField("Required", text: $model.articleEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                            
                            if model.articleEntryText.isEmpty
                            {
                                Button("Paste") {
                                    model.articleEntryText = UIPasteboard.general.string ?? ""
                                }
                            }
                        }
                        .padding([.leading, .trailing], 24)
                        
                        Text("Provide topic or keyword")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 34)
                    }
                    
                    if model.isEmptyArticleScreen, !model.articleEntryText.isEmpty
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
                            Text("Generating Article...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultArticleScreen
                    {
                        ResultView(generatedText: model.generatedArticleText)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Article")
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
                    
                    if !model.generatedArticleText.isEmpty
                    {
                        Button("Reset") {
                            model.articleEntryText = ""
                            model.generatedArticleText = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeArticle()
                    let articles = ["My name is Paris", "I am a human"]
                    model.generatedArticleText = articles.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking || model.articleEntryText.isEmpty)
            }
        }
    }
}
