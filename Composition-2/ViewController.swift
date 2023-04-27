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

extension ViewController: UICollectionViewDelegate {
    
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
        case .example(let example):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingSoonCollectionViewCell", for: indexPath) as? ExampleCollectionViewCell else {return .init()}
            cell.configureCell(imageName: example[indexPath.row].imageName)
            return cell
        }
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderSupplementaryView
            header.configureHeader(cathegoryName: sections[indexPath.section].title)
            return header
        default: return UICollectionReusableView()
        }
        
    }
    
    
}
