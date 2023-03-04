//
//  AffirmationView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct AffirmationView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                if model.isEmptyAffirmationScreen
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
                
                if model.hasResultAffirmationScreen
                {
                    ResultView(generatedText: model.generatedAffirmation, textSize: 28)
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
                    if !model.generatedAffirmation.isEmpty
                    {
                        Button("Reset") {
                            model.generatedAffirmation = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeAffirmation()
                    let affirmation = ["Eat", "Sleep", "Create", "Dance"]
                    model.generatedAffirmation = affirmation.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking)
            }
        }
    }
}
