//
//  DetailsView.swift
//  Wallet App UI
//
//  Created by Yash Shah on 03/03/22.
//

import Foundation
import UIKit

public protocol DetailsViewDelegate: AnyObject {
    func didCloseDetailsView(_ detailsView: DetailsView)
}

public final class DetailsView: UIView {
    
    private let cardView: CardView
    private let initialFrameForCardView: CGRect
    private let tableView = UITableView()
    private var shouldAnimateCells = true
    
    public weak var delegate: DetailsViewDelegate?
    
    var dataSource = ["Airbnb", "Amazon Pay", "Amazon", "Apple", "Google Chrome", "Google Pay", "Instagram", "Line", "Pandora", "Pinterest", "Shazam", "Snapchat", "Telegram"]
    
    public init(withCardView cardView: CardView, initialFrameForCardView initialFrame: CGRect) {
        self.cardView = cardView
        self.initialFrameForCardView = initialFrame
        super.init(frame: .zero)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        dataSource.shuffle()
        addSubview(cardView)
        cardView.frame = initialFrameForCardView
        cardView.delegate = self
        
        backgroundColor = UIColor.darkGray.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.5) {
            self.cardView.frame.origin.y = CommonFunctions.getStatusBarHeight()
            self.tableView.frame.origin.y = self.cardView.frame.maxY + 20
            self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        } completion: { completed in
            guard completed else { return }
            self.setupTableView()
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.cardView.frame.maxY + 20
            }
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.frame = CGRect(origin: CGPoint(x: frame.origin.x + 16, y: frame.maxY),
                                 size: CGSize(width: frame.width - 32, height: frame.maxY - cardView.frame.maxY - 20))
        tableView.layer.cornerRadius = 20
        tableView.layer.cornerCurve = .continuous
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: ExpenseTableViewCell.self.description())
    }
}

extension DetailsView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseTableViewCell.self.description(), for: indexPath) as? ExpenseTableViewCell else { return UITableViewCell() }
        cell.setData(forBrandTitle: dataSource[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard shouldAnimateCells else { return }
        let delay: TimeInterval = 0.2 * Double(indexPath.row + 1)
        cell.alpha = 0
        cell.transform = .init(translationX: 0, y: -15)
        UIView.animate(withDuration: 0.3,
                       delay: delay,
                       options: .curveEaseInOut) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shouldAnimateCells = false
    }
}

extension DetailsView: CardViewDelegate {
    
    public func didTapCardView(_ cardView: CardView) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.frame.origin.y = self.frame.maxY
        } completion: { completed in
            guard completed else { return }
            UIView.animate(withDuration: 0.5) {
                self.cardView.frame = self.initialFrameForCardView
                self.backgroundColor = UIColor.lightGray.withAlphaComponent(0)
            } completion: { completed in
                guard completed else { return }
                self.delegate?.didCloseDetailsView(self)
                self.removeFromSuperview()
            }
        }
    }
}
