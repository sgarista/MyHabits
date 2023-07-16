import UIKit

enum Fonts {
    
    case title3
    case headline
    case body
    case footnoteSemibold13
    case footnoteStatusSemibold13
    case footnoteRegular13
    case caption
    
    
    var type: UIFont {
        switch self {
            
        case .title3:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .headline:
            return  UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .body:
            return  UIFont.systemFont(ofSize: 17, weight: .regular)
        case .footnoteSemibold13:
            return  UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .footnoteStatusSemibold13:
            return  UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .footnoteRegular13:
            return  UIFont.systemFont(ofSize: 13, weight: .regular)
        case .caption:
            return  UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
}
