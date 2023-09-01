//
//  PushToGroupCell.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-31.
//

import UIKit

class PushToGroupCell: UITableViewCell {
    //MARK: - UI 컴포넌트
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SUITE-Bold", size: 22.0)
        label.textColor = ColorManager.kPrimaryColor
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SUITE-Bold", size: 18.0)
        label.textColor = .systemGray4
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, number: Int) {
        titleLabel.text = title
        countLabel.text = String(number)
    }
    
    func setUI() {
        contentView.addSubviews([titleLabel, countLabel])
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    func setLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
