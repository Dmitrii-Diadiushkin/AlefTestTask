//
//  AgeView.swift
//  TestTask
//
//  Created by Dmitrii Diadiushkin on 09.03.2022.
//

import UIKit

final class AgeView: UIView {
    
    private var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Возраст"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var ageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
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
        self.addSubview(ageLabel)
        self.addSubview(ageTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: ageLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: ageLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: ageTextField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: ageTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: ageTextField, attribute: .top, relatedBy: .equal, toItem: ageLabel, attribute: .bottom, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: ageTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10)
        ])
        
        self.layer.cornerRadius = CGFloat(5.0)
        self.layer.borderWidth = CGFloat(1.0)
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.ageTextField.becomeFirstResponder()
    }
    
    func cleanAge() {
        ageTextField.text = ""
    }
}
