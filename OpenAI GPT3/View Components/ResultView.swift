//
//  ResultView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 03/03/23.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject private var model: AppModel
    
    var generatedText: String
    var textSize: CGFloat
    
    var showCopyButton: Bool
    
    @Binding var copyButtonTitle: String
    
    init(generatedText: String, textSize: CGFloat = 20, showCopyButton: Bool = false, copyButtonTitle: Binding<String> = Binding.constant("Copy"))
    {
        self.generatedText = generatedText
        self.textSize = textSize
        self.showCopyButton = showCopyButton
        self._copyButtonTitle = copyButtonTitle
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(generatedText)
                .padding(8)
                .font(.system(size: textSize))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .contextMenu {
                    Button {
                        UIPasteboard.general.string = generatedText
                        copyButtonTitle = "Copied to clipboard!"
                    } label: {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                }
            
            if showCopyButton
            {
                Button {
                    UIPasteboard.general.string = generatedText
                    copyButtonTitle = "Copied to clipboard!"
                } label: {
                    Label(copyButtonTitle, systemImage: "doc.on.doc")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(Color(.secondarySystemFill).cornerRadius(10))
        .padding(24)
    }
}
