//
//  CathegoryCollectionViewCell.swift
//  Composition-2
//
//  Created by Дмитрий Лоренц on 26.04.2023.
//

import UIKit
import SnapKit

class CathegoryCollectionViewCell: UICollectionViewCell {
    private let cathegoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cathegoryBurger")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cathegoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Cathegory"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.red.cgColor
                layer.borderWidth = 2
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        addSubview(cathegoryLabel)
        addSubview(cathegoryImageView)
    }
    
    func setConstraints() {
        
        cathegoryLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(-5)
            make.height.equalTo(16)
        
        }
        
        cathegoryImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(-5)
            make.bottom.equalTo(cathegoryLabel.snp.top)
        }
        
       
    }
    
    func configureCell(cathegoryName: String, imageName: String) {
        cathegoryImageView.image = UIImage(named: imageName)
        cathegoryLabel.text = cathegoryName
        
    }
}
