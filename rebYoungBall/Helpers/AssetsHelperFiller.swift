



import SwiftUI

enum AssetsHelperFiller {
    struct images {
        static let mainBackground: Image = Image("mainBackground")
        static let menuLogo: Image = Image("menuLogo")
    }
    
    struct icons {
        static let backArrow: Image = Image("icon-backarrow")
        static let howToPlay: Image = Image("icon-htp")
        static let gearSettings: Image = Image("icon-gear")
        
        static let pauseGame: Image = Image("icon-pause")
        static let restartGame: Image = Image("icon-respawn")
        
        static let checkBox: Image = Image("icon-checkbox")
    }
    
    struct colors {
        static let redBackground: Color = Color(hex: "#850F13")
    }
    
    struct texts {
        static let howToPlayFull: String = """
Use the buttons at the bottom of the screen to control the green ball and bring it to the finish line.

Avoid traps, chasms and enemies along the way.

In each level, you need to come up with a strategy to win. Good luck!
"""
    }
}
