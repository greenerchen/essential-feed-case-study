//
//  ErrorView.swift
//  EssentialFeedsiOS
//
//  Created by Greener Chen on 2023/9/28.
//

import UIKit

public class ErrorView: UIButton {
    public var message: String? {
        get { return isVisible ? configuration?.title : nil }
        set { setMessageAnimated(newValue) }
    }
    
    public var onHide: (() -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        var configuration = Configuration.plain()
        configuration.titlePadding = 0
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .errorBackgroundColor
        configuration.background.cornerRadius = 0
        self.configuration = configuration
        
        addTarget(self, action: #selector(hideMessageAnimated), for: .touchUpInside)
        hideMessage()
    }
    
    private var titleAttributes: AttributeContainer {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return AttributeContainer([
            .paragraphStyle: paragraphStyle,
            .font: UIFont.preferredFont(forTextStyle: .body)
        ])
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        hideMessage()
    }
    
    private var isVisible: Bool {
        alpha > 0
    }
    
    private func setMessageAnimated(_ message: String?) {
        if let message = message {
            showAnimated(message)
        } else {
            hideMessageAnimated()
        }
    }
    
    func showAnimated(_ message: String) {
        configuration?.attributedTitle = AttributedString(message, attributes: titleAttributes)
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    @objc
    func hideMessageAnimated() {
        UIView.animate(withDuration: 0.25,
                       animations: { self.alpha = 0 }) { completed in
            if completed {
                self.hideMessage()
            }
        }
    }
    
    @IBAction func hideMessage() {
        alpha = 0
        configuration?.attributedTitle = nil
        configuration?.contentInsets = .zero
        onHide?()
    }
}

extension ErrorView {
    func makeContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        container.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            self.topAnchor.constraint(equalTo: container.topAnchor),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
}

extension UIColor {
    static var errorBackgroundColor: UIColor {
        UIColor(red: 0.99951404330000004, green: 0.41759261489999999, blue: 0.4154433012, alpha: 1)
    }
}
