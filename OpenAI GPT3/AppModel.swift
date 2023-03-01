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
    
    private var client: OpenAISwift?
    
    func setup()
    {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) -> Void)
    {
        isThinking = true
        // The completion handler takes in an result of the type OpenAI.
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
