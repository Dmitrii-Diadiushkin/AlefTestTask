//
//  NameView.swift
//  TestTask
//
//  Created by Dmitrii Diadiushkin on 09.03.2022.
//

import UIKit

final class NameView: UIView {
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(nameLabel)
        self.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameTextField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: nameTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: nameTextField, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: nameTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10)
        ])
        
        self.layer.cornerRadius = CGFloat(5.0)
        self.layer.borderWidth = CGFloat(1.0)
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.nameTextField.becomeFirstResponder()
    }
}
