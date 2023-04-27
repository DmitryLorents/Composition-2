//
//  HeaderSuplementaryView.swift
//  Composition-2
//
//  Created by Дмитрий Лоренц on 27.04.2023.
//

import UIKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize:16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        backgroundColor = .white
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(cathegoryName: String) {
        headerLabel.text = cathegoryName
    }
    
    private func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
    }
    
}
