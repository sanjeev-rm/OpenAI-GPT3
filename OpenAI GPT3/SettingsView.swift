//
//  SettingsView.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 01/03/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var model: AppModel
    
    var body: some View {
        Image(systemName: "gearshape.fill")
            .dynamicTypeSize(.accessibility5)
            .foregroundColor(.accentColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
