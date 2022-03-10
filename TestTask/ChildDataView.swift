//
//  ChildDataView.swift
//  TestTask
//
//  Created by Dmitrii Diadiushkin on 09.03.2022.
//

import UIKit

protocol ChildDataViewDelegate: AnyObject {
    func removeView()
}

final class ChildDataView: UIView {
    
    weak var delegate: ChildDataViewDelegate?
    
    private var personalDataView = PersonalDataView()
    
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(personalDataView)
        
        personalDataView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: personalDataView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: personalDataView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: personalDataView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: personalDataView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        self.addSubview(deleteButton)
        
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)

        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: deleteButton, attribute: .left, relatedBy: .equal, toItem: personalDataView, attribute: .right, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        ])
    }
    
    @objc private func handleDelete() {
        self.removeFromSuperview()
        delegate?.removeView()
    }
}
