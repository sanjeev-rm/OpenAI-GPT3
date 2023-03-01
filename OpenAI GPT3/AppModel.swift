//
//  AppModel.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 01/03/23.
//

import Foundation
import OpenAISwift

// final keyword means that this calss will not be inherited.
final class AppModel: ObservableObject
{
    @Published var isThinking: Bool = false
    @Published var selectedModule: Modules? // An optional cause in the begining of our app we will not have a selected module so it'll be nil.S
    
    private var client: OpenAISwift?
    
    func setup()
    {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) -> Void)
    {
        isThinking = true
        // The completion handler takes in an result of the type OpenAI. This is the result returned by the API.
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result
            {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure(_):
                let output = "Oops! Error generating output."
                completion(output)
            }
        })
    }
}

enum Modules: CaseIterable, Identifiable
{
    case newChat
    
    var id: String {
        return title
    }
    var title: String {
        switch self {
        case .newChat:
            return "New Chat"
        }
    }
    
    var sfSymbol: String {
        switch self {
        case .newChat:
            return "text.bubble"
        }
    }
}
