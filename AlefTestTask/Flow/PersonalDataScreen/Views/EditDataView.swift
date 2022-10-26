//
//  EditDataView.swift
//  AlefTestTask
//
//  Created by Dmitrii Diadiushkin on 25.10.2022.
//

import UIKit

final class EditDataView: UIView {
    
    enum EditDataViewType: String {
        case name
        case age
        
        func getTitle() -> String {
            switch self {
            case .name:
                return AppText.nameLabelTitle
            case .age:
                return AppText.ageLabelTitle
            }
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private var dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        return textField
    }()
    
    init(viewType: EditDataViewType) {
        super.init(frame: .zero)
        titleLabel.text = viewType.getTitle()
        if viewType == .age {
            dataTextField.keyboardType = .numberPad
        }
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(dataTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: dataTextField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: dataTextField, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: dataTextField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: dataTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10)
        ])
        
        layer.cornerRadius = CGFloat(5.0)
        layer.borderWidth = CGFloat(1.0)
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        dataTextField.becomeFirstResponder()
    }
    
    func cleanData() {
        dataTextField.text = nil
    }
}
