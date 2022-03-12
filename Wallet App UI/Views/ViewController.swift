//
//  ViewController.swift
//  Wallet App UI
//
//  Created by Yash Shah on 01/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let headerView = NavigationHeader()
    
    var areCardsCollapsed = true
    var selectedCardView: CardView?
    
    var cardViewCollapsedTopConstraints: [NSLayoutConstraint] = []
    var cardViewExpandedTopConstraints: [NSLayoutConstraint] = []
    var usedCardIndexSet = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        view.addSubview(headerView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        scrollView.contentInset.bottom = 20
        scrollView.delegate = self
        
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerView.layer.shadowRadius = 12
        headerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.12).cgColor
        headerView.layer.shadowOpacity = 0
        
        let numberOfCardsToShow = Int.random(in: 3...7)
        var lastCard: CardView? = nil
        
        for index in 1...numberOfCardsToShow {
            let cardView = createCardView()
            if lastCard == nil {
                cardView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            } else {
                let expandedTopConstraint = cardView.topAnchor.constraint(equalTo: lastCard!.bottomAnchor)
                cardViewExpandedTopConstraints.append(expandedTopConstraint)
                let collapsedTopConstraint = cardView.topAnchor.constraint(equalTo: lastCard!.topAnchor, constant: 60)
                cardViewCollapsedTopConstraints.append(collapsedTopConstraint)
            }
            if index == numberOfCardsToShow {
                cardView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor).isActive = true
            }
            lastCard = cardView
        }
        
        headerView.updateNavHeader(shouldHideRightButton: areCardsCollapsed, animated: false)
        updateCardTopConstraints(isCollapsed: areCardsCollapsed, animated: false)
    }
    
    func updateCardTopConstraints(isCollapsed: Bool, animated: Bool) {
        cardViewCollapsedTopConstraints.forEach({ $0.isActive = isCollapsed })
        cardViewExpandedTopConstraints.forEach({ $0.isActive = !isCollapsed })
        if animated {
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.5, options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }

    func createCardView() -> CardView {
        var randomNumber: Int
        repeat {
            randomNumber = Int.random(in: 1...15)
        } while (usedCardIndexSet.contains(randomNumber))
        usedCardIndexSet.insert(randomNumber)
        let cardView = CardView(imageName: "\(randomNumber)")
        cardView.delegate = self
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        return cardView
    }
}

extension ViewController: CardViewDelegate {
    
    func didTapCardView(_ cardView: CardView) {
        if areCardsCollapsed {
            areCardsCollapsed.toggle()
            headerView.updateNavHeader(shouldHideRightButton: areCardsCollapsed, animated: true)
            updateCardTopConstraints(isCollapsed: areCardsCollapsed, animated: true)
        } else {
            selectedCardView = cardView
            cardView.alpha = 0
            let detailsView = DetailsView(withCardView: CardView(imageName: cardView.imageName),
                                          initialFrameForCardView: scrollView.convert(cardView.frame, to: view))
            view.addSubview(detailsView)
            detailsView.translatesAutoresizingMaskIntoConstraints = false
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            detailsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            detailsView.delegate = self
        }
    }
}

extension ViewController: NavigationHeaderDelegate {
    
    func didTapRightButton(_ navHeader: NavigationHeader) {
        if !areCardsCollapsed {
            areCardsCollapsed.toggle()
            headerView.updateNavHeader(shouldHideRightButton: areCardsCollapsed, animated: true)
            updateCardTopConstraints(isCollapsed: areCardsCollapsed, animated: true)
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.layer.shadowOpacity = (scrollView.contentOffset.y > 0) ? 1 : 0
    }
}

extension ViewController: DetailsViewDelegate {
    
    func didCloseDetailsView(_ detailsView: DetailsView) {
        selectedCardView?.alpha = 1
        selectedCardView = nil
    }
}

