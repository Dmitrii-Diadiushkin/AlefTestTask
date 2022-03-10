//
//  ViewController.swift
//  TestTask
//
//  Created by Dmitrii Diadiushkin on 09.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var personalDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Персональные данные"
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        
        return label
    }()
    
    private var personalDataView = PersonalDataView()
    
    private var childLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Дети (макс. 5)"
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        
        return label
    }()
    
    private var addChildButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        let imageSelected = UIImage(systemName: "plus")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(imageSelected, for: .highlighted)
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitleColor(.blue, for: .highlighted)
        
        button.layer.borderWidth = CGFloat(2.0)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private var childStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CGFloat(10.0)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        initialConfigure()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    private func initialConfigure() {
        configurePersonalDataLabel()
        configurePersonalDataView()
        configureAddChildButton()
        configureChildLabel()
        configureStackView()
    }
    
    private func configurePersonalDataLabel() {
        view.addSubview(personalDataLabel)
        
        guard let safeAreaTop = UIApplication.shared.windows.first?.safeAreaInsets.top else {
            print("Something wrong with safe area")
            return
        }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: personalDataLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: personalDataLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: personalDataLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: safeAreaTop + 15)
        ])
        
    }
    
    private func configurePersonalDataView() {
        view.addSubview(personalDataView)
        
        personalDataView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: personalDataView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: personalDataView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: personalDataView, attribute: .top, relatedBy: .equal, toItem: personalDataLabel, attribute: .bottom, multiplier: 1, constant: 15)
        ])
    }
    
    private func configureAddChildButton() {
        view.addSubview(addChildButton)
        
        addChildButton.addTarget(self, action: #selector(tempConfigureChildData), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: addChildButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: addChildButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: addChildButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: addChildButton, attribute: .top, relatedBy: .equal, toItem: personalDataView, attribute: .bottom, multiplier: 1, constant: 10)
        ])
        
    }
    
    private func configureChildLabel() {
        view.addSubview(childLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: childLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: childLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: childLabel, attribute: .centerY, relatedBy: .equal, toItem: addChildButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    private func configureStackView() {
        view.addSubview(childStackView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: childStackView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: childStackView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: childStackView, attribute: .top, relatedBy: .equal, toItem: addChildButton, attribute: .bottom, multiplier: 1, constant: 20)
        ])
    }
    
    @objc private func tempConfigureChildData() {
        let childData = ChildDataView()
        childData.delegate = self
        childStackView.addArrangedSubview(childData)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}

extension ViewController: ChildDataViewDelegate {
    func removeView() {
         print("Removing")
    }
}
