//
//  NextView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct NextView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                if model.isEmptyNextScreen
                {
                    Text("Tap 'Generate' in the top right corner of your screen")
                        .foregroundColor(.gray)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                }
                
                if model.isThinking
                {
                    Text("Generating Response...")
                    ProgressView().progressViewStyle(.circular)
                }
                
                if model.hasResultNextScreen
                {
                    ResultView(generatedText: model.generatedNext, textSize: 28)
                }
            }
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
                    if !model.generatedNext.isEmpty
                    {
                        Button("Reset") {
                            model.generatedNext = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeNext()
                    let nexts = ["Eat", "Sleep", "Create", "Dance"]
                    model.generatedNext = nexts.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking)
            }
        }
    }
}
