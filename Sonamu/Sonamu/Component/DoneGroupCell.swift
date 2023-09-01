//
//  DoneGroupCell.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-29.
//

import UIKit

class DoneGroupCell: UITableViewCell {
    //MARK: - UI 컴포넌트
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.layer.cornerRadius = CGFloat(8)
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SUITE-Bold", size: 16.0)
        label.textColor = ColorManager.kPrimaryColor
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
    
    func configure(with done: Done){
        self.titleLabel.text = done.content
    }
    
    func setUI() {
        contentView.addSubviews([iconImageView, titleLabel])
        contentView.clipsToBounds = true
    }
    
    func setLayout() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: CGFloat(16)),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
