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
        VStack {
            Image(systemName: "globe")
                .padding(8)
                .foregroundColor(.accentColor)
                .dynamicTypeSize(.xxxLarge)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ModulesView_Previews: PreviewProvider {
    static var previews: some View {
        ModulesView()
    }
}
