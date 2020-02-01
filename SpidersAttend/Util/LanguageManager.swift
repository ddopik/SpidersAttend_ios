//
//  LanguageManager.swift
//  SpidersAttend
//
//  Created by ddopik on 7/20/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit

class  LanguageManager {
    
    ///
    /// The singleton LanguageManager instance.
    ///
    public static let shared: LanguageManager = LanguageManager()
    
    ///
    /// The current language.
    ///
    public var currentLanguage: Languages {
        get {
            guard let currentLang = UserDefaults.standard.string(forKey: Constants.defaultsKeys.selectedLanguage) else {
               return .en
//                fatalError("Did you set the default language for the app ?")
            }
            return Languages(rawValue: currentLang)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Constants.defaultsKeys.selectedLanguage)
        }
    }
    
    ///
    /// The default language that the app will run first time.
    /// You need to set the `defaultLanguage` in the `AppDelegate`, specifically in
    /// the first line inside `application(_:willFinishLaunchingWithOptions:)`.
    ///
    public var defaultLanguage: Languages {
        get {
            
            guard let defaultLanguage = UserDefaults.standard.string(forKey: Constants.defaultsKeys.defaultLanguage) else {
                fatalError("Did you set the default language for the app ?")
            }
            return Languages(rawValue: defaultLanguage)!
        }
        set {
            
            // swizzle the awakeFromNib from nib and localize the text in the new awakeFromNib
            UIView.localize()
            
            let defaultLanguage = UserDefaults.standard.string(forKey: Constants.defaultsKeys.defaultLanguage)
            guard defaultLanguage == nil else {
                setLanguage(language: currentLanguage)
                return
            }
            
            var language = newValue
            if language == .deviceLanguage {
                language = deviceLanguage ?? .en
            }
            
            UserDefaults.standard.set(language.rawValue, forKey: Constants.defaultsKeys.defaultLanguage)
            UserDefaults.standard.set(language.rawValue, forKey: Constants.defaultsKeys.selectedLanguage)
            setLanguage(language: language)
        }
    }
    
    ///
    /// The device language is deffrent than the app language,
    /// to get the app language use `currentLanguage`.
    ///
    public var deviceLanguage: Languages? {
        get {
            
            guard let deviceLanguage = Bundle.main.preferredLocalizations.first else {
                return nil
            }
            return Languages(rawValue: deviceLanguage)
        }
    }
    
    /// The diriction of the language.
    public var isRightToLeft: Bool {
        get {
            return isLanguageRightToLeft(language: currentLanguage)
        }
    }
    
    /// The app locale to use it in dates and currency.
    public var appLocale: Locale {
        get {
            return Locale(identifier: currentLanguage.rawValue)
        }
    }
    
    ///
    /// Set the current language of the app
    ///
    /// - parameter language: The language that you need the app to run with.
    /// - parameter rootViewController: The new view controller to show after changing the language.
    /// - parameter animation: A closure with the current view to animate to the new view controller,
    ///                        so you need to animate the view, move it out of the screen, change the alpha,
    ///                        or scale it down to zero.
    ///
    public func setLanguage(language: Languages, rootViewController: UIViewController? = nil, animation: ((UIView) -> Void)? = nil) {
        
        // change the dircation of the views
        let semanticContentAttribute: UISemanticContentAttribute = isLanguageRightToLeft(language: language) ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = semanticContentAttribute
        
        // set current language
        currentLanguage = language
        
        guard let rootViewController = rootViewController else {
            return
        }
        
        let snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
        rootViewController.view.addSubview(snapshot);
        
        UIApplication.shared.delegate?.window??.rootViewController = rootViewController
        
        UIView.animate(withDuration: 0.5, animations: {
            animation?(snapshot)
        }) { _ in
            snapshot.removeFromSuperview()
        }
        
    }
    
    private func isLanguageRightToLeft(language: Languages) -> Bool {
        return Locale.characterDirection(forLanguage: language.rawValue) == .rightToLeft
    }
    
}

// MARK: - Languages
public enum Languages: String {
    case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,
    ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he,ur,fa,ku,arc,sl,ml
    case enGB = "en-GB"
    case enAU = "en-AU"
    case enCA = "en-CA"
    case enIN = "en-IN"
    case frCA = "fr-CA"
    case esMX = "es-MX"
    case ptBR = "pt-BR"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case zhHK = "zh-HK"
    case es419 = "es-419"
    case ptPT = "pt-PT"
    case deviceLanguage
}

// MARK: - Swizzling
fileprivate extension UIView {
    static func localize() {
        
        let orginalSelector = #selector(awakeFromNib)
        let swizzledSelector = #selector(swizzledAwakeFromNib)
        
        let orginalMethod = class_getInstanceMethod(self, orginalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod!), method_getTypeEncoding(orginalMethod!))
        } else {
            method_exchangeImplementations(orginalMethod!, swizzledMethod!)
        }
        
    }
    
    @objc func swizzledAwakeFromNib() {
        swizzledAwakeFromNib()
        
        switch self {
        case let txtf as UITextField:
            txtf.text = txtf.text?.localiz()
            txtf.placeholder = txtf.placeholder?.localiz()
        case let lbl as UILabel:
            lbl.text = lbl.text?.localiz()
        case let btn as UIButton:
            btn.setTitle(btn.title(for: .normal)?.localiz(), for: .normal)
        case let sgmnt as UISegmentedControl:
            (0 ..< sgmnt.numberOfSegments).forEach { sgmnt.setTitle(sgmnt.titleForSegment(at: $0)?.localiz(), forSegmentAt: $0) }
        case let txtv as UITextView:
            txtv.text = txtv.text?.localiz()
        default:
            break
        }
    }
}

// MARK: - String extension
public extension String {
    
    ///
    /// Localize the current string to the selected language
    ///
    /// - returns: The localized string
    ///
    func localiz(comment: String = "") -> String {
        guard let bundle = Bundle.main.path(forResource: PrefUtil.getAppLanguage(), ofType: "lproj") else {
            return NSLocalizedString(self, comment: comment)
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
    }
    
}

// MARK: - ImageDirection
public enum ImageDirection: Int {
    case fixed, leftToRight, rightToLeft
}

private extension UIView {
    ///
    /// Change the direction of the image depeneding in the language, there is no return value for this variable.
    /// The expectid values:
    ///
    /// -`fixed`: if the image must not change the direction depending on the language you need to set the value as 0.
    ///
    /// -`leftToRight`: if the image must change the direction depending on the language
    /// and the image is left to right image then you need to set the value as 1.
    ///
    /// -`rightToLeft`: if the image must change the direction depending on the language
    /// and the image is right to left image then you need to set the value as 2.
    ///
    var direction: ImageDirection {
        set {
            switch newValue {
            case .fixed:
                break
            case .leftToRight where LanguageManager.shared.isRightToLeft:
                transform = CGAffineTransform(scaleX: -1, y: 1)
            case .rightToLeft where !LanguageManager.shared.isRightToLeft:
                transform = CGAffineTransform(scaleX: -1, y: 1)
            default:
                break
            }
        }
        get {
            fatalError("There is no value return from this variable, this variable used to change the image direction depending on the langauge")
        }
    }
}

@IBDesignable
public extension UIImageView {
    @IBInspectable var imageDirection: Int {
        set {
            direction = ImageDirection(rawValue: newValue)!
        }
        get {
            return direction.rawValue
        }
    }
}

@IBDesignable
public extension UIButton {
    @IBInspectable var imageDirection: Int {
        set {
            direction = ImageDirection(rawValue: newValue)!
        }
        get {
            return direction.rawValue
        }
    }
}

// MARK: - Constants
fileprivate enum Constants {
    
    enum defaultsKeys {
        static let selectedLanguage = "LanguageManagerSelectedLanguage"
        static let defaultLanguage = "LanguageManagerDefaultLanguage"
    }
    
    enum strings {
        static let unlocalized = "<unlocalized>"
    }
}
