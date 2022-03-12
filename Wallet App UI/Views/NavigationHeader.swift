//
//  NavigationHeader.swift
//  Wallet App UI
//
//  Created by Yash Shah on 01/03/22.
//

import Foundation
import UIKit

public protocol NavigationHeaderDelegate: AnyObject {
    func didTapRightButton(_ navHeader: NavigationHeader)
}

public final class NavigationHeader: UIView {
    
    let titleLabel = UILabel()
    let rightImage = UIImageView()
    
    var titleLabelLeadingConstraint: NSLayoutConstraint?
    var titleLabelCenterXConstraint: NSLayoutConstraint?
    public weak var delegate: NavigationHeaderDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        heightAnchor.constraint(equalToConstant: CommonFunctions.getStatusBarHeight() + 48).isActive = true
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(rightImage)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        titleLabel.text = "Wallet"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabelCenterXConstraint = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        titleLabelCenterXConstraint?.isActive = true
        titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        titleLabelLeadingConstraint?.isActive = false
        
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        rightImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        rightImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        rightImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        rightImage.heightAnchor.constraint(equalTo: rightImage.widthAnchor).isActive = true
        rightImage.image = UIImage(systemName: "xmark.circle.fill")
        rightImage.tintColor = .systemBlue
        rightImage.alpha = 0
        rightImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped))
        rightImage.addGestureRecognizer(tapGesture)
    }
    
    func updateNavHeader(shouldHideRightButton isHidden: Bool, animated: Bool) {
        titleLabelLeadingConstraint?.isActive = !isHidden
        titleLabelCenterXConstraint?.isActive = isHidden
        if animated {
            UIView.animate(withDuration: 0.4) {
                self.rightImage.alpha = isHidden ? 0 : 1
                self.layoutIfNeeded()
            }
        } else {
            rightImage.alpha = isHidden ? 0 : 1
            layoutIfNeeded()
        }
    }
    
    @objc func rightImageTapped() {
        delegate?.didTapRightButton(self)
    }
}
