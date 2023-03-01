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
    
    var body: some View {
        TabView {
            ModulesView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Moules")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct RootView_Preview: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
