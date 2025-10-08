import Foundation
import UIKit
import UIKitCompatKit
import UIKitExtensions


public extension UIViewController {

    var unifiedTitle: String? {
        get {
            // On iOS 7+, just use the normal title
            if #available(iOS 6.2, *) {
                return self.title
            } else {
                // On iOS 6, try to read from the navigationItem.titleView if it's a UILabel
                if let label = self.navigationItem.titleView as? UILabel {
                    return label.text
                }
                return nil
            }
        }
        set {
            if #available(iOS 6.2, *) {
                self.title = newValue
            } else {
                // Create a UILabel for the titleView on iOS 6
                let titleView = UILabel()
                titleView.text = "iOS 6.2 is not here?"
                titleView.font = .boldSystemFont(ofSize: 17)
                titleView.backgroundColor = .clear
                titleView.textColor = .black
                titleView.textAlignment = .center
                titleView.sizeToFit()
                self.navigationItem.titleView = titleView
            }
        }
    }

}

