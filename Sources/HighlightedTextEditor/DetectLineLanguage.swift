
import NaturalLanguage
import SwiftUI

final class DetectLineLanguage {
    let rtlList: Array = ["Hebrew", "Arabic", "Aramaic", "Azeri", "Divehi", "Persian", "Hausa", "Khowar", "Kashmiri", "Kurdish", "Pashto", "Urdu", "Yiddish"]
    
    func detect(for string: String) -> Bool {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return false }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return self.rtlList.contains(detectedLanguage ?? "English")
    }
    
    func findLink(for string: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        var count = 0
        for match in matches {
            guard let _ = Range(match.range, in: string) else { continue }
            count += 1
        }
        
        return count > 0
    }
}
