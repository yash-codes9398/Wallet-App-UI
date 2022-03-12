//
//  CardView.swift
//  Wallet App UI
//
//  Created by Yash Shah on 01/03/22.
//

import Foundation
import UIKit

public protocol CardViewDelegate: AnyObject {
    func didTapCardView(_ cardView: CardView)
}

public final class CardView: UIView {
    
    let cardImageView = UIImageView()
    
    public let imageName: String
    public weak var delegate: CardViewDelegate?
    
    public init(imageName: String) {
        self.imageName = imageName
        super.init(frame: .zero)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        addSubview(cardImageView)
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.backgroundColor = [.green, .blue, .gray, .black, .purple, .brown, .cyan].randomElement()
        
        cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        cardImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardImageView.widthAnchor.constraint(equalTo: cardImageView.heightAnchor, multiplier: 1.5906040268).isActive = true
        cardImageView.layer.cornerRadius = 20
        cardImageView.layer.cornerCurve = .continuous
        cardImageView.clipsToBounds = true
        cardImageView.image = UIImage(named: imageName)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func viewTapped() {
        delegate?.didTapCardView(self)
    }
}
