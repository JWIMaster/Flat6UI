import Foundation
import UIKit
import UIKitCompatKit
import UIKitExtensions

public class Flat6UIViewController: UIViewController { }

public class Flat6UINavigationController: UINavigationController {
    public init(rootVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [rootVC]
        if #unavailable(iOS 7.0.1) {
            self.moderniOSNavBar()
            self.navigationItem.rightBarButtonItem = .flat6Item(title: "Done", target: self, action: #selector(backTapped))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

public class Flat6UIWindow: UIWindow {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.moderniOSStatusBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.moderniOSStatusBar()
    }
    
    private var statusBarAdded = false
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        if !statusBarAdded {
            self.moderniOSStatusBar()
            statusBarAdded = true
        }
    }
}

extension UINavigationController {
    fileprivate func moderniOSNavBar() {
        if #unavailable(iOS 7.0.1) {
            self.navigationBar.backgroundColor = .white
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.tintColor = .white
        }
    }
}

extension UIWindow {
    public func moderniOSStatusBar(backgroundColor: UIColor = .white) {
        if #unavailable(iOS 7.0.1) {
            let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 20))
            statusBar.backgroundColor = backgroundColor
            statusBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            
            let timeLabel = UILabel()
            timeLabel.textAlignment = .center
            timeLabel.textColor = .black
            timeLabel.backgroundColor = .clear
            timeLabel.font = UIFont.systemFont(ofSize: 12.5, weight: .bold)
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            timeLabel.text = timeFormatter.string(from: Date())
            
            Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                timeLabel.text = timeFormatter.string(from: Date())
            }
            
            statusBar.addSubview(timeLabel)
            
            NSLayoutConstraint.activate([
                timeLabel.centerXAnchor.constraint(equalTo: statusBar.centerXAnchor),
                timeLabel.centerYAnchor.constraint(equalTo: statusBar.centerYAnchor)
            ])
            
            self.addSubview(statusBar)
            self.bringSubviewToFront(statusBar)
        }
    }
}


public extension UIBarButtonItem {
    static func flat6Item(title: String,
                          target: Any?,
                          action: Selector,
                          tintColor: UIColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(tintColor, for: .normal)
        button.setTitleColor(tintColor.withAlphaComponent(0.5), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
}
