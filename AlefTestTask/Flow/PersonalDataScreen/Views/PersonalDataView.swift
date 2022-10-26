//
//  PersonalDataView.swift
//  AlefTestTask
//
//  Created by Dmitrii Diadiushkin on 25.10.2022.
//

import UIKit

final class PersonalDataView: UIView {
    
    private(set) var nameView = EditDataView(viewType: .name)
    private(set) var ageView = EditDataView(viewType: .age)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameView)
        addSubview(ageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nameView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nameView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: ageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: ageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: ageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: ageView, attribute: .top, relatedBy: .equal, toItem: nameView, attribute: .bottom, multiplier: 1, constant: 10)
        ])
    }
    
    func cleanData() {
        nameView.cleanData()
        ageView.cleanData()
    }
}
