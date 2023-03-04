//
//  ComparisonView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import SwiftUI

struct ComparisonView: View {
    
    @EnvironmentObject private var model: AppModel
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.accentColor)
                            .dynamicTypeSize(.accessibility5)
                        
                        VStack {
                            HStack {
                                TextField("Required", text: $model.comparisonEntryText1, axis: .vertical)
                                    .focused($fieldIsFocused)
                                    .padding(8)
                                    .background(Color(.secondarySystemFill).cornerRadius(10))
                                
                                if model.comparisonEntryText1.isEmpty
                                {
                                    Button("Paste") {
                                        model.comparisonEntryText1 = UIPasteboard.general.string ?? ""
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
                        
                        VStack {
                            HStack {
                                TextField("Required", text: $model.comparisonEntryText2, axis: .vertical)
                                    .focused($fieldIsFocused)
                                    .padding(8)
                                    .background(Color(.secondarySystemFill).cornerRadius(10))
                                
                                if model.comparisonEntryText2.isEmpty
                                {
                                    Button("Paste") {
                                        model.comparisonEntryText2 = UIPasteboard.general.string ?? ""
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
                    }
                    
                    if model.isEmptyComparisonScreen, !model.comparisonEntryText1.isEmpty, !model.comparisonEntryText2.isEmpty
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
                            Text("Generating Comparison...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultComparisonScreen
                    {
                        ResultView(generatedText: model.generatedComparisonText)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Compare")
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
                    
                    if !model.generatedComparisonText.isEmpty
                    {
                        Button("Reset") {
                            model.comparisonEntryText1 = ""
                            model.comparisonEntryText2 = ""
                            model.generatedComparisonText = ""
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
//                    model.makeComparison()
                    let comparison = ["1. Definition: Space generally refers to the vast expanse beyond the Earth's atmosphere, including celestial objects such as stars and planets. Outer space specifically refers to the region beyond the Earth's atmosphere where there is no air or atmosphere to breathe and where the laws of physics differ from those experienced on Earth.\n\n2. Altitude: Space can refer to areas of altitude above Earth's surface, while outer space specifically refers to areas beyond the Earth's atmosphere.\n\n3. Visibility: Objects in space are visible from Earth, while objects in outer space are generally too far away to be seen without the aid of telescopes or other instruments.\n\n4. Gravity: In space, objects are still within the gravitational pull of Earth, while in outer space, objects are beyond Earth's gravity and are floating freely in the vacuum of space.\n\n5. Conditions: In space, there is still some atmosphere and air pressure, while in outer space, there is no air pressure or atmosphere, making it a vacuum. This creates different conditions that affect how objects behave and interact.\n\n6. Exploration: Space is explored through telescopes, satellites, and manned spacecraft, while outer space is only explored through unmanned spacecraft and probes.\n\n7. Temperature: Space has a wide range of temperatures, but outer space is much colder as there is no atmosphere to trap heat."]
                    model.generatedComparisonText = comparison.randomElement()!
                    model.isThinking = false
                }.disabled(model.isThinking || model.comparisonEntryText1.isEmpty || model.comparisonEntryText2.isEmpty)
            }
        }
    }
}
