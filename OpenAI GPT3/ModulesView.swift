//
//  ModulesView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 01/03/23.
//

import SwiftUI

struct ModulesView: View {
    
    @EnvironmentObject private var model: AppModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(Modules.allCases) { module in
                    Button {
                        model.selectedModule = module
                    } label: {
                        Label {
                            Text(module.title)
                                .font(.system(size: 20, weight: .medium))
                                .padding(.vertical, 10)
                        } icon: {
                            Image(systemName: module.sfSymbol)
                        }
                    }
                }
            }
            .navigationTitle("Modules")
            .sheet(item: $model.selectedModule) { screen in
                switch screen {
                case .newChat:
                    NewChatView()
                }
            }
        }
    }
}
