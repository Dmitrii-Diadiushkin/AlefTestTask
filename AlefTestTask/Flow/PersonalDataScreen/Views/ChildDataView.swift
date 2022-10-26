//
//  ChildDataView.swift
//  AlefTestTask
//
//  Created by Dmitrii Diadiushkin on 25.10.2022.
//

import UIKit

protocol ChildDataViewDelegate: AnyObject {
    func removeChildDataView()
}

final class ChildDataView: UIView {
    
    weak var delegate: ChildDataViewDelegate?
    
    private var personalDataView = PersonalDataView()
    
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppText.deleteButtonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        addSubview(separatorView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: separatorView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: separatorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: separatorView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: separatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        ])
        
        addSubview(personalDataView)
        
        personalDataView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: personalDataView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: personalDataView, attribute: .top, relatedBy: .equal, toItem: separatorView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: personalDataView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: personalDataView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        addSubview(deleteButton)
        
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)

        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: deleteButton, attribute: .left, relatedBy: .equal, toItem: personalDataView, attribute: .right, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: deleteButton, attribute: .centerY, relatedBy: .equal, toItem: personalDataView.nameView, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    @objc private func handleDelete() {
        removeFromSuperview()
        delegate?.removeChildDataView()
    }
    
    func hideSeparator() {
        separatorView.isHidden = true
    }
}
