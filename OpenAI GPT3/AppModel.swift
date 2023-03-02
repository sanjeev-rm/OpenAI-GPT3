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
    @Published var selectedModule: Modules? // An optional cause in the begining of our app we will not have a selected module so it'll be nil.
    
    /// This is the text entered by the user.
    @Published var newChatEntryText: String = ""
    /// This contains the response/output from the API.
    @Published var generatedNewChatText: String = ""
    /// Stores wether the new chat screen is Empty i.e. is it retreiving and if the generated text is empty.
    var isEmptyNewChatScreen: Bool {
        return !isThinking && generatedNewChatText.isEmpty
    }
    /// Stores the new chat screen response received from the API.
    var hasResultNewChatScreen: Bool {
        return !isThinking && !generatedNewChatText.isEmpty
    }
    
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
    
    /// This function sends the new text to the API.
    /// When the output is generated the generatedNewChatText is assigned adn isThinking is set to false.
    func makeNewChat()
    {
        send(text: "\(newChatEntryText)") { output in
            DispatchQueue.main.async {
                self.generatedNewChatText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                // Setting this to false cause the output has been generated.
                self.isThinking = false
            }
        }
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
