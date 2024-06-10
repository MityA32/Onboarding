//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let onboardingPageView = OnboardingPageView()
    private let actionButton = OnboardingActionButton()

    var viewModel: OnboardingScreensViewModel? {
        didSet {
            setup()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    private func setup() {
        setupBackground()
        setupLayout()
        setupDelegates()
        setupRx()
    }
    
    private func setupBackground() {
        view.backgroundColor = .hexF1F1F5
    }
    
    private func setupLayout() {
        view.addSubview(onboardingPageView)
        onboardingPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(48)
            $0.height.equalTo(56)
        }
    }
    
    private func setupRx() {
        guard let viewModel else { return }
        viewModel.currentPage
            .bind { [weak self] page in
                self?.setupPage(page)
            }
            .disposed(by: disposeBag)
        
        actionButton.rx.tap
            .bind(to: viewModel.inNewPageClick)
            .disposed(by: disposeBag)
        
        onboardingPageView.subscriptionPageView.subscriptionManagerBarView.inCloseClick
            .bind(to: viewModel.inCloseClick)
            .disposed(by: onboardingPageView.subscriptionPageView.subscriptionManagerBarView.disposeBag)
    }
    
    private func setupDelegates() {
        onboardingPageView.itemsPageView.onboardingItemsCollectionView?.dataSource = self
        onboardingPageView.itemsPageView.onboardingItemsCollectionView?.delegate = self
    }
    
    private func setupPage(_ page: OnboardingPageSetup) {
        guard let viewModel else { return }
        if page.id == viewModel.onboardingPages.count {
            print(page)
            onboardingPageView.showSubscription()
            actionButton.setupAppearence(type: .subscription)
        } else {
            onboardingPageView.itemsPageView.onboardingItemsCollectionView?.scrollToItem(
                at: IndexPath(item: page.id - 1, section: 0),
                at: .centeredHorizontally,
                animated: true)
            actionButton.setupAppearence(type: .question)
//            if let question = page.item?.question {
//                onboardingPageView.itemsPageView.setQuestion(question)
//            }
        }
        
    }


}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.onboardingPages.filter { $0.type == .question }.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardingPageView.itemsPageView.onboardingItemsCollectionView?.dequeueReusableCell(withReuseIdentifier: OnboardingCardsCollectionViewCell.id, for: indexPath) as! OnboardingCardsCollectionViewCell
        cell.configureCell(viewModel?.onboardingPages[indexPath.row].item)
        return cell
    }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width - 48
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let sideInset = (collectionView.bounds.width - (collectionView.bounds.width - 48)) / 2
            return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 24
        }

}

