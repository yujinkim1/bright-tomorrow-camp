//
//  TodoGroupCell.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-25.
//

import UIKit

protocol CheckBoxButtonDelegate: AnyObject {
	func didTapCheckBoxButton(in cell: TodoGroupCell)
}

class TodoGroupCell: UITableViewCell {
	//MARK: - 델리게이트
	weak var checkBoxButtonDelegate: CheckBoxButtonDelegate?
	
	//MARK: - UI 컴포넌트
	lazy var iconImageView: UIImageView = {
		let view = UIImageView()
		view.tintColor = .white
		view.layer.cornerRadius = CGFloat(8)
		view.contentMode = .scaleAspectFit
		view.layer.masksToBounds = true
		return view
	}()
	
	lazy var checkboxButton: UIButton = {
		let button = UIButton()
		button.tintColor = ColorManager.kPrimaryColor
		button.setImage(UIImage(named: "roundedCircle"), for: .normal)
		button.setImage(UIImage(named: "roundedCircleFill"), for: .selected)
		button.clipsToBounds = true
		button.isSelected = true
		return button
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
	
	func configure(with todo: Todo){
		self.titleLabel.text = todo.content
	}
	
	func setUI() {
		iconImageView.addSubview(checkboxButton)
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
	
	func addTarget() {
		checkboxButton.addTarget(self, action: #selector(checkBoxButtonTapped(_:)), for: .touchUpInside)
	}
	
	@objc
	func checkBoxButtonTapped(_ button: UIButton) {
		button.isSelected.toggle()
		checkBoxButtonDelegate?.didTapCheckBoxButton(in: self)
	}
}
