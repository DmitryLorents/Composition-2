//
//  ViewController.swift
//  Composition-2
//
//  Created by Дмитрий Лоренц on 26.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .none
        collectionview.bounces = false
        return collectionview
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Make an order", for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private let sections = MockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "FoodShop"
        view.addSubview(orderButton)
        view.addSubview(collectionView)
        collectionView.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: "StoriesCollectionViewCell")
        collectionView.register(CathegoryCollectionViewCell.self, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        collectionView.register(ExampleCollectionViewCell.self, forCellWithReuseIdentifier: "ComingSoonCollectionViewCell")
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setConstraints() {
        orderButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(orderButton.snp.top).inset(-10)
        }
        
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
//MARK: Create layout

extension ViewController: UICollectionViewDelegate {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self  = self else {return nil}
            let section = self.sections[sectionIndex]
            switch section {
                
            case .sales(_):
                return self.createSaleSection()
            case .cathegory(_):
                return self.createCathegorySection()
            case .example(_):
                return self.createExampleSection()
            }
        }
        
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup, behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, interGroupSpacing: CGFloat, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem], contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
        
    }
    
    private func createSaleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.2)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: -10, bottom: 0, trailing: 0)
        return section
    }
    
    private func createCathegorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func createExampleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.45)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
}

//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
       
        case .sales(let sale) :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as? SaleCollectionViewCell else {return .init()}
            cell.configureCell(imageName: sale[indexPath.row].imageName)
            return cell
            
        case.cathegory(let cathegory):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? CathegoryCollectionViewCell else {return .init()}
            cell.configureCell(cathegoryName: cathegory[indexPath.row].title, imageName: cathegory[indexPath.row].imageName)
            return cell

        case .example(let example):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingSoonCollectionViewCell", for: indexPath) as? ExampleCollectionViewCell else {return .init()}
            cell.configureCell(imageName: example[indexPath.row].imageName)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as! HeaderSupplementaryView
            header.configureHeader(cathegoryName: sections[indexPath.section].title)
            return header
        default: return UICollectionReusableView()
        }
        
    }
    
    
}
