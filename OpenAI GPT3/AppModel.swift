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
    @Published var displayModeString: String = "Light"
    var appDisplayColorScheme: ColorScheme? {
        return displayModeString == "System" ? nil : (displayModeString == "Dark" ? .dark : .light)
    }
    
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
    
    // MARK: The variables for the Definition module view.
    @Published var definitionEntryText: String = ""
    @Published var generatedDefinitionText: String = ""
    var isEmptyDefinitionScreen: Bool { !isThinking && generatedDefinitionText.isEmpty }
    var hasResultDefinitionScreen: Bool { !isThinking && !generatedDefinitionText.isEmpty }
    
    // MARK: The variables for the Article module view.
    @Published var articleEntryText: String = ""
    @Published var generatedArticleText: String = ""
    var isEmptyArticleScreen: Bool { !isThinking && generatedArticleText.isEmpty }
    var hasResultArticleScreen: Bool { !isThinking && !generatedArticleText.isEmpty }
    
    // MARK: The variables for the Expanded module view.
    @Published var expandedEntryText: String = ""
    @Published var generatedExpandedText: String = ""
    var isEmptyExpandedScreen: Bool { !isThinking && generatedExpandedText.isEmpty }
    var hasResultExpandedScreen: Bool { !isThinking && !generatedExpandedText.isEmpty }
    
    // MARK: The variables for the Summarized module view.
    @Published var summarizeEntryText: String = ""
    @Published var generatedSummarizedText: String = ""
    var isEmptySummarizedScreen: Bool { !isThinking && generatedSummarizedText.isEmpty }
    var hasResultSummarizedScreen: Bool { !isThinking && !generatedSummarizedText.isEmpty }
    
    // MARK: The variables for the Comparison module view.
    @Published var comparisonEntryText1: String = ""
    @Published var comparisonEntryText2: String = ""
    @Published var generatedComparisonText: String = ""
    var isEmptyComparisonScreen: Bool { !isThinking && generatedComparisonText.isEmpty }
    var hasResultComparisonScreen: Bool { !isThinking && !generatedComparisonText.isEmpty }
    
    // MARK: The variables for the Next module view.
    @Published var generatedNext: String = ""
    var isEmptyNextScreen: Bool { !isThinking && generatedNext.isEmpty }
    var hasResultNextScreen: Bool { !isThinking && !generatedNext.isEmpty }
    
    // MARK: The variables for the Affirmation module view.
    @Published var generatedAffirmation: String = ""
    var isEmptyAffirmationScreen: Bool { !isThinking && generatedAffirmation.isEmpty }
    var hasResultAffirmationScreen: Bool { !isThinking && !generatedAffirmation.isEmpty }
    
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
    /// Function for the Related topics module view.
    /// Generates the related topics and sets the values in the view.
    func makeRelatedTopics()
    {
        send(text: "Generate 5 topics that are closely related to \(generatedRelatedTopicsText). Simply provide the related topics seperated by new line.") { output in
            DispatchQueue.main.async {
                self.generatedRelatedTopicsText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Definition module view.
    /// Function for the Definition module view.
    /// Generates the Definition and sets the values in the view.
    func makeDefinition()
    {
        send(text: "Provide the defenition of \(definitionEntryText).") { output in
            DispatchQueue.main.async {
                self.generatedDefinitionText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Article module view.
    /// Function for the Article module view.
    /// Generates the Article and sets the values in the view.
    func makeArticle()
    {
        send(text: "Generate an in-depth, grounded in reality, 1-paragraph wikipedia article for a reader who does not understand the topic of \(articleEntryText). Simply provide the generated article.") { output in
            DispatchQueue.main.async {
                self.generatedArticleText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Expanded module view.
    /// Function for the Expanded module view.
    /// Generates the Expanded and sets the values in the view.
    func makeExpanded()
    {
        send(text: "Expand on the following text: \"\(expandedEntryText)\".") { output in
            DispatchQueue.main.async {
                self.generatedExpandedText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Summarized module view.
    /// Function for the Summarized module view.
    /// Generates the Summarized and sets the values in the view.
    func makeSummarized()
    {
        send(text: "Summarize the following text, readable by an 8th grader: \"\(summarizeEntryText)\".") { output in
            DispatchQueue.main.async {
                self.generatedSummarizedText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Comparison module view.
    /// Function for the Comparison module view.
    /// Generates the Comparison and sets the values in the view.
    func makeComparison()
    {
        send(text: "Provide a list of differences between: \"\(comparisonEntryText1)\" and \"\(comparisonEntryText2)\".") { output in
            DispatchQueue.main.async {
                self.generatedComparisonText = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Next module view.
    /// Function for the Comparison module view.
    /// Generates the Comparison and sets the values in the view.
    func makeNext()
    {
        send(text: "Provide a random but important, single thing to think about on the topic of daily living in the form of a direction for me to follow right now. Be specific.") { output in
            DispatchQueue.main.async {
                self.generatedNext = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
    
    // MARK: Function for the Affirmation module view.
    /// Function for the Affirmation module view.
    /// Generates the Affirmation and sets the values in the view.
    func makeAffirmation()
    {
        send(text: "Generate an affirmation I can tell myself that will subtly fill me with life and smiles and that is not too confusing. Provide the affirmation without quotes.") { output in
            DispatchQueue.main.async {
                self.generatedAffirmation = output.trimmingCharacters(in: .whitespacesAndNewlines)
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
    case definition
    case article
    case expanded
    case summarized
    case comparison
    case next
    case affirmation
    
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
        case .definition:
            return "Definition"
        case .article:
            return "Article"
        case .expanded:
            return "Expand Text"
        case .summarized:
            return "Summarize Text"
        case .comparison:
            return "Compare"
        case .next:
            return "Next"
        case .affirmation:
            return "Affirmation"
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
        case .definition:
            return "exclamationmark.circle"
        case .article:
            return "book"
        case .expanded:
            return "rectangle.expand.vertical"
        case .summarized:
            return "rectangle.compress.vertical"
        case .comparison:
            return "arrow.up.arrow.down"
        case .next:
            return "arrowshape.right"
        case .affirmation:
            return "checkmark.seal"
        }
    }
}
