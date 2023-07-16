import UIKit


enum Colors {

    case blue
    case blueviolet
    case green
    case lightgray
    case orange
    case systemgray
    case systemgray2
    case violet
    case tableSectionHeader

    var color: UIColor {
        
        switch self {

        case .blue:
            return UIColor(named: "Blue") ?? UIColor(red: 41.0, green: 109.0, blue: 255.0, alpha: 1.0)
        case .blueviolet:
            return UIColor(named: "BlueViolet") ?? UIColor(red: 98.0, green: 54.0, blue: 255.0, alpha: 1.0)
        case .green:
            return UIColor(named: "Green") ?? UIColor(red: 29.0, green: 179.0, blue: 34.0, alpha: 1.0)
        case .lightgray:
            return UIColor(named: "LightGray") ?? UIColor(red: 242.0, green: 242.0, blue: 247.0, alpha: 1.0)
        case .orange:
            return UIColor(named: "Orange") ?? UIColor(red: 255.0, green: 159.0, blue: 79.0, alpha: 1.0)
        case .systemgray:
            return UIColor(named: "SystemGray") ?? UIColor.systemGray
        case .systemgray2:
            return UIColor(named: "SystemGray2") ?? UIColor.systemGray2
        case .violet:
            return UIColor(named: "Violet") ?? UIColor(red: 161.0, green: 22.0, blue: 204.0, alpha: 1.0)
        case .tableSectionHeader:
            return UIColor(named: "TableSectionHeader") ?? UIColor(red: 60.0, green: 60.0, blue: 67.0, alpha: 0.6)
        }
    }
}







