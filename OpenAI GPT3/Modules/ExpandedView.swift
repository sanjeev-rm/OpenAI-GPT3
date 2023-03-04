//
//  ExpandedView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct ExpandedView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack {
                        Image(systemName: "arrow.up.and.line.horizontal.and.arrow.down")
                            .foregroundColor(.accentColor)
                            .dynamicTypeSize(.accessibility5)
                        
                        HStack {
                            TextField("Required", text: $model.expandedEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                            
                            if model.expandedEntryText.isEmpty
                            {
                                Button("Paste") {
                                    model.expandedEntryText = UIPasteboard.general.string ?? ""
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
                    
                    if model.isEmptyExpandedScreen, !model.expandedEntryText.isEmpty
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
                            Text("Generating Response...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultExpandedScreen
                    {
                        ResultView(generatedText: model.generatedExpandedText)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Expanded")
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
                    
                    if !model.generatedExpandedText.isEmpty
                    {
                        Button("Reset") {
                            model.expandedEntryText = ""
                            model.generatedExpandedText = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeExpanded()
                    let expanded = ["The exploration of space has been one of the most exciting and awe-inspiring endeavors that humanity has ever undertaken. From the earliest days of gazing up at the stars and wondering what lay beyond, to the modern era of sending spacecraft to explore the furthest reaches of our solar system and beyond, the exploration of space has captured the imagination and inspired countless people.\n\nOne of the reasons that space is so exciting is the vastness and mystery of it all. The universe is an enormous, complex, and largely unknown place, with countless mysteries waiting to be unraveled. There are so many questions about the cosmos that we still don't have answers to, such as whether there is life on other planets, what dark matter is made of, and what caused the Big Bang that created the universe.\n\nSpace exploration is also exciting because of the technological challenges involved. It requires cutting-edge engineering, science, and technology to design and launch spacecraft that can survive the harsh conditions of space and carry out scientific experiments and observations. The development of new technologies and innovations to tackle these challenges has led to many spin-off benefits for society, such as advances in medical imaging, computing, and communication.\n\nIn addition to the scientific and technological aspects, space also has a cultural and inspirational significance. It has inspired countless works of literature, film, and art, and has captured the imaginations of generations of people. The idea of exploring new worlds and encountering alien life forms has been a staple of science fiction for decades, and the real-life exploration of space has sparked the curiosity and wonder of people around the world.\n\nOverall, the exploration of space is exciting because of the many scientific, technological, cultural, and inspirational aspects involved. As we continue to learn more about the universe and our place in it, we are sure to discover even more wonders and mysteries that will continue to inspire and excite us."]
                    model.generatedExpandedText = expanded.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking || model.expandedEntryText.isEmpty)
            }
        }
    }
}
