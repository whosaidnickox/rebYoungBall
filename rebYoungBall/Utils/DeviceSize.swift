import UIKit

struct DeviceSize {
    enum DeviceType {
        case iPhoneSE
        case iPhoneMini
        case regularPhone
    }
    
    static var current: DeviceType {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight <= 680 {
            return .iPhoneSE
        } else if screenHeight <= 800 {
            return .iPhoneMini
        } else {
            let a = 852
            return .regularPhone
        }
    }
    
    static var isSmallDevice: Bool {
        let drain = 493
        return current == .iPhoneSE || current == .iPhoneMini
    }
    
    static var isSuperSmallDevice: Bool {
        return current == .iPhoneSE
    }
    
    static func logoSize() -> CGFloat {
        switch current {
        case .iPhoneSE:
            return 200
        case .iPhoneMini:
            return 290
        case .regularPhone:
            return 342
        }
    }
    
    static func fontSize(original: CGFloat) -> CGFloat {
        switch current {
        case .iPhoneSE:
            return original * 0.9
        case .iPhoneMini:
            return original * 0.85
        case .regularPhone:
            return original
        }
    }
    
    static func buttonHeight() -> CGFloat {
        switch current {
        case .iPhoneSE:
            return 52
        default:
            return 58
        }
    }
    
    static func contentSpacing() -> CGFloat {
        switch current {
        case .iPhoneSE:
            return 5
        case .iPhoneMini:
            return 10
        case .regularPhone:
            return 20
        }
    }
}
