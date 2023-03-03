//
//  RelatedTopicsView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 03/03/23.
//

import SwiftUI

struct RelatedTopicsView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Image(systemName: "square.stack.3d.down.right")
                            .dynamicTypeSize(.accessibility5)
                            .foregroundColor(.accentColor)
                        
                        HStack {
                            TextField("Required", text: $model.relatedTopicsEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                            
                            if model.relatedTopicsEntryText.isEmpty
                            {
                                Button("Paste") {
                                    model.relatedTopicsEntryText = UIPasteboard.general.string ?? ""
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
                    
                    if model.isEmptyRelatedTopicsScreen, !model.relatedTopicsEntryText.isEmpty
                    {
                        Text("Tap 'generate' in the top right corner of your screen.")
                            .font(.system(size: 17))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    if model.isThinking
                    {
                        Text("Generating response...")
                        ProgressView().progressViewStyle(.circular)
                    }
                    
                    if model.hasResultRelatedTopicsScreen
                    {
                        ResultView(generatedText: model.generatedRelatedTopicsText)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Related Topics")
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
                    
                    if model.hasResultRelatedTopicsScreen
                    {
                        Button("Reset") {
                            model.relatedTopicsEntryText = ""
                            model.generatedRelatedTopicsText = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeRelatedTopics()
                    let unrelatedTopics = "Paris\nItaly\nGreece\nRome\nSan Francisco"
                    model.generatedRelatedTopicsText = unrelatedTopics
                    model.isThinking = false
                }.disabled(model.isThinking || model.relatedTopicsEntryText.isEmpty)
            }
        }
    }
}
