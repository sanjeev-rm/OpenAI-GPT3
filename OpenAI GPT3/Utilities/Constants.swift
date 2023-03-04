//
//  Constants.swift
//  OpenAI GPT3
//
//  Created by Sanjeev RM on 04/03/23.
//

import Foundation

enum AppInfo
{
    /// The email of the support. Email to be contacted to for issues.
    static let SUPPORT_EMAIL = "sanjeevraghu2050@gmail.com"
    
    // The version number of the app. This returns the version we write general of the info file.
    /// The version number of the app.
    static let VERSION_NUMBER = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
}
