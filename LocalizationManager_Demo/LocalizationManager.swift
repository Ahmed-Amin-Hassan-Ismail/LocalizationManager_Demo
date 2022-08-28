//
//  LocalizationManager.swift
//  LocalizationManager_Demo
//
//  Created by Ahmed Amin on 28/08/2022.
//

import Foundation
import UIKit

protocol LocalizationDelegate: AnyObject {
    func resetApp()
}


class LocalizationManager: NSObject {
    
    enum LanguageDirection {
        case leftToRight
        case rightToLeft
    }
    
    enum Language: String {
        case English = "en"
        case Arabic = "ar"
    }
    
    
    //MARK: - Variables
    static let shared: LocalizationManager = LocalizationManager()
    private var bundle: Bundle? = nil
    private let languageKey: String = "UKPrefLang"
    weak var delegate: LocalizationDelegate?
    
    private override init() {
        super.init()
    }
    
    
    
    //MARK: - get current lang
    func getLanguage() -> Language? {
        guard let languageCode = UserDefaults.standard.string(forKey: languageKey),
              let language = Language(rawValue: languageCode) else {
            return nil
        }
        return language
    }
    
    //MARK: - if lang is available
    private func isLanguageAvailable(_ code: String) -> Language? {
        var finalCode = ""
        if code.contains("ar") {
            finalCode = "ar"
        } else if code.contains("en") {
            finalCode = "en"
        }
        return Language(rawValue: finalCode)
    }
    
    //MARK: - check language direction
    private func getLanguageDirection() -> LanguageDirection {
        guard let lang = getLanguage() else { return .leftToRight}
       
        switch lang {
        case .English:
            return .leftToRight
        case .Arabic:
            return .rightToLeft
        }
    }
    
    
    //MARK: - get localized string
    func localizedString(for key: String, value comment: String) -> String {
        let localized = bundle!.localizedString(forKey: key, value: comment, table: nil)
        return localized
    }
    
    //MARK: - Set Language
    func setLanguage(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: languageKey)
        if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj") {
            bundle = Bundle(path: path)
        } else {
            // fallback
            resetLocalization()
        }
        UserDefaults.standard.synchronize()
        resetApp()
    }
    
    private func resetLocalization() {
        bundle = Bundle.main
    }
    
    private func resetApp() {
        let dir = getLanguageDirection()
        let semantic: UISemanticContentAttribute!
        switch dir {
        case .leftToRight:
            semantic = .forceLeftToRight
        case .rightToLeft:
            semantic = .forceRightToLeft
        }
        
        UITabBar.appearance().semanticContentAttribute = semantic
        UINavigationBar.appearance().semanticContentAttribute = semantic
        UIView.appearance().semanticContentAttribute = semantic
        
        delegate?.resetApp()
    }
    
    
    //MARK: - configure startup lang
    func setAppInitLanguage() {
        if let selectedLang = getLanguage() {
            setLanguage(language: selectedLang)
        } else {
            // no lang selected
            let langCode = Locale.preferredLanguages.first
            if let langCode = langCode,
               let lang = isLanguageAvailable(langCode) {
                setLanguage(language: lang)
            } else {
                // fallback
                setLanguage(language: .English)
            }
        }
        resetApp()
    }
}


extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(for: self, value: "")
    }
}
