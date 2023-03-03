//
//  AppModel.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 01/03/23.
//

import SwiftUI
import OpenAISwift

// final keyword means that this calss will not be inherited.
final class AppModel: ObservableObject
{
    @Published var isThinking: Bool = false
    @Published var selectedModule: Modules? // An optional cause in the begining of our app we will not have a selected module so it'll be nil.
    
    // MARK: The variables for the New Chat module view.
    /// This is the text entered by the user.
    @Published var newChatEntryText: String = ""
    /// This contains the response/output from the API.
    @Published var generatedNewChatText: String = ""
    /// Stores wether the new chat screen is Empty i.e. is it retreiving and if the generated text is empty.
    var isEmptyNewChatScreen: Bool { !isThinking && generatedNewChatText.isEmpty }
    /// Stores the new chat screen response received from the API.
    var hasResultNewChatScreen: Bool { !isThinking && !generatedNewChatText.isEmpty }
    
    // MARK: The variables for the Random Concept module view.
    @Published var generatedConcept: String = ""
    var isEmptyConceptScreen: Bool { !isThinking && generatedConcept.isEmpty }
    var hasResultConceptScreen: Bool { !isThinking && !generatedConcept.isEmpty }
    
    // MARK: The variables for the Related Topics module view.
    @Published var relatedTopicsEntryText: String = ""
    @Published var generatedRelatedTopicsText: String = ""
    var isEmptyRelatedTopicsScreen: Bool { !isThinking && generatedRelatedTopicsText.isEmpty }
    var hasResultRelatedTopicsScreen: Bool { !isThinking && !generatedRelatedTopicsText.isEmpty }
    
    private var client: OpenAISwift?
    
    func setup()
    {
        client = OpenAISwift(authToken: "API_KEY")
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
    
    // MARK: Function for the New Chat module view.
    /// Function for the New Chat module view
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
    
    //MARK: Function for the Random Concept module view.
    /// Function for the Random Concept module view.
    /// Generates the concept and sets the values in the view.
    func makeConcept()
    {
        send(text: "Generate a concept, generally a word or many, in the realm of anything, that is grounded in reality, and may or may not be valuable to learn about. Simply provide the short concept without punctuation.") { output in
            DispatchQueue.main.async {
                self.generatedConcept = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Related Topics module view.
    func makeRelatedTopics()
    {
        send(text: "Generate 5 topics that are closely related to \(self.generatedRelatedTopicsText). Simply provide the related topics seperated by new line.") { output in
            DispatchQueue.main.async {
                self.generatedRelatedTopicsText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
}

enum Modules: CaseIterable, Identifiable
{
    case newChat
    case randomConcept
    case relatedTopics
    
    var id: String {
        return title
    }
    var title: String {
        switch self {
        case .newChat:
            return "New Chat"
        case .randomConcept:
            return "Random Concept"
        case .relatedTopics:
            return "Related Topics"
        }
    }
    
    var sfSymbol: String {
        switch self {
        case .newChat:
            return "text.bubble"
        case .randomConcept:
            return "lightbulb"
        case .relatedTopics:
            return "square.stack.3d.up"
        }
    }
}
