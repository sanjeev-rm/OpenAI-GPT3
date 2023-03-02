//
//  NewChatView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 01/03/23.
//

import SwiftUI

struct NewChatView: View {
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                VStack {
                    Image(systemName: "globe")
                        .foregroundColor(.accentColor)
                        .dynamicTypeSize(.accessibility5)
                    
                    HStack {
                        TextField("Required", text: $model.newChatEntryText, axis: .vertical)
                            .padding(8)
                            .background(Color(.secondarySystemFill).cornerRadius(10))
                        
                        if model.newChatEntryText.isEmpty
                        {
                            Button("Paste") {
                                model.newChatEntryText = UIPasteboard.general.string ?? ""
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
                
                if model.isEmptyNewChatScreen, !model.newChatEntryText.isEmpty
                {
                    Text("Tap 'Send' in the top right corner of your screen")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                if model.isThinking
                {
                    VStack {
                        Text("Generating Response...")
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                
                if model.hasResultNewChatScreen
                {
                    Text(model.generatedNewChatText)
                }
            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        
                        if !model.generatedNewChatText.isEmpty
                        {
                            Button("Reset") {
                                model.newChatEntryText = ""
                                model.generatedNewChatText = ""
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Send") {
                        model.makeNewChat()
                    }
                }
            }
        }
    }
}
