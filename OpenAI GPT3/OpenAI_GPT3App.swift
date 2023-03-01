//
//  OpenAI_GPT3App.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 28/02/23.
//

import SwiftUI

@main
struct OpenAI_GPT3App: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    
    @ObservedObject private var model = AppModel()
    
    var body: some View {
        TabView {
            ModulesView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Modules")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(model)
        .onAppear {
            model.setup()
        }
    }
}

struct RootView_Preview: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
