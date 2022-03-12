//
//  ExpenseTableViewCell.swift
//  Wallet App UI
//
//  Created by Yash Shah on 03/03/22.
//

import Foundation
import UIKit

public final class ExpenseTableViewCell: UITableViewCell {
    
    private let appImageView = UIImageView()
    private let brandLabel = UILabel()
    private let amountLabel = UILabel()
    private let dateLabel = UILabel()
    private let rightContainerView = UIView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        contentView.addSubview(appImageView)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        appImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        appImageView.heightAnchor.constraint(equalTo: appImageView.widthAnchor).isActive = true
        appImageView.clipsToBounds = true
        appImageView.layer.cornerRadius = 12
        
        contentView.addSubview(brandLabel)
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.leadingAnchor.constraint(equalTo: appImageView.trailingAnchor, constant: 20).isActive = true
        brandLabel.centerYAnchor.constraint(equalTo: appImageView.centerYAnchor).isActive = true
        brandLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        brandLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        
        contentView.addSubview(rightContainerView)
        rightContainerView.translatesAutoresizingMaskIntoConstraints = false
        rightContainerView.leadingAnchor.constraint(equalTo: brandLabel.trailingAnchor, constant: 20).isActive = true
        rightContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        rightContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        rightContainerView.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor).isActive = true
        amountLabel.topAnchor.constraint(equalTo: rightContainerView.topAnchor).isActive = true
        amountLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        
        rightContainerView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor).isActive = true
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textColor = UIColor.gray
        
        rightContainerView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16).isActive = true
        let appImageViewTopConstraint = appImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        appImageViewTopConstraint.priority = UILayoutPriority(999)
        appImageViewTopConstraint.isActive = true
        
        amountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: rightContainerView.leadingAnchor).isActive = true
        let dateLabelLeadingConstraint = dateLabel.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor)
        dateLabelLeadingConstraint.priority = UILayoutPriority(999)
        dateLabelLeadingConstraint.isActive = true
    }
    
    public func setData(forBrandTitle title: String) {
        appImageView.image = UIImage(named: title)
        brandLabel.text = title
        amountLabel.text = "$\(Int.random(in: 50...5000))"
        dateLabel.text = "\(Int.random(in: 1...28))/\(Int.random(in: 1...12))/202\(Int.random(in: 1...2))"
    }
}
