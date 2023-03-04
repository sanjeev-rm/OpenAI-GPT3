//
//  ConceptView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 03/03/23.
//

import SwiftUI

struct ConceptView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var copyButtonTitle: String = "Copy"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                if model.isEmptyConceptScreen
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
                
                if model.hasResultConceptScreen
                {
                    ResultView(generatedText: model.generatedConcept, textSize: 28, showCopyButton: true, copyButtonTitle: $copyButtonTitle)
                }
            }
            .navigationTitle("Random Concept")
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
                    if !model.generatedConcept.isEmpty
                    {
                        Button("Reset") {
                            copyButtonTitle = "Copy"
                            model.generatedConcept = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
                    copyButtonTitle = "Copy"
//                    model.makeConcept()
                    let concepts = ["Gravity", "App Dev", "IOS Dev", "Gravitational Time Dilation"]
                    model.generatedConcept = concepts.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking)
            }
        }
    }
}
