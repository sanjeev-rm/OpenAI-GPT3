//
//  DefinitionView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct DefinitionView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Image(systemName: "brain")
                            .foregroundColor(.accentColor)
                            .dynamicTypeSize(.accessibility5)
                        
                        HStack {
                            TextField("Required", text: $model.definitionEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                            
                            if model.definitionEntryText.isEmpty
                            {
                                Button("Paste") {
                                    model.definitionEntryText = UIPasteboard.general.string ?? ""
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
                    
                    if model.isEmptyNewChatScreen, !model.newChatEntryText.isEmpty
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
                            Text("Generating Definition...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultDefinitionScreen
                    {
                        ResultView(generatedText: model.generatedDefinitionText)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Definition")
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
                    
                    if !model.generatedDefinitionText.isEmpty
                    {
                        Button("Reset") {
                            model.definitionEntryText = ""
                            model.generatedDefinitionText = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeDefinition()
                    let definitions = [
                        "gravitational time dilation": "Gravitational time dilation occurs because objects with a lot of mass create a strong gravitational field. The gravitational field is really a curving of space and time. The stronger the gravity, the more spacetime curves, and the slower time itself proceeds.",
                        "gravity": "In physics, gravity is a fundamental interaction which causes mutual attraction between all things with mass or energy."
                    ]
                    model.generatedDefinitionText = definitions[model.definitionEntryText.lowercased()] ?? "Opps! Definition not found..."
                    model.isThinking = false
                }.disabled(model.isThinking || model.definitionEntryText.isEmpty)
            }
        }
    }
}
