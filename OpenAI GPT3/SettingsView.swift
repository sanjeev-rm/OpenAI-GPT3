//
//  SettingsView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 01/03/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var model: AppModel
    
    let displayOptions = ["Light", "Dark", "System"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    Picker("Display mode", selection: $model.displayModeString) {
                        ForEach(displayOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Contact") {
                    Button {
                        EmailHelper.shared.sendEmail(subject: "OpenAI GPT3 v\(AppInfo.VERSION_NUMBER)", body: "", to: AppInfo.SUPPORT_EMAIL)
                    } label: {
                        Label("Email Support", systemImage: "tray.and.arrow.up")
                    }

                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(model.appDisplayColorScheme)
    }
}
