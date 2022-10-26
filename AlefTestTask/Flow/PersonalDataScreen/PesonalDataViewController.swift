//
//  PesonalDataViewController.swift
//  AlefTestTask
//
//  Created by Dmitrii Diadiushkin on 25.10.2022.
//

import UIKit

class PesonalDataViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private var personalDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppText.personalDataLabelTitle
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private let personalDataView = PersonalDataView()
    
    private var childLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppText.childLabelTitle
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private var addChildButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: AppText.addChildButtonImageName), for: .normal)
        let imageSelected = UIImage(systemName: AppText.addChildButtonImageName)?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        button.setImage(imageSelected, for: .highlighted)
        button.setTitle(AppText.addChildButtonTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 16.0)
        
        button.layer.borderWidth = CGFloat(2.0)
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.6).cgColor
        
        return button
    }()
    
    private var childStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CGFloat(10.0)
        
        return stackView
    }()
    
    private var cleanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AppText.cleanButtonTitle, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        
        button.layer.borderWidth = CGFloat(2.0)
        button.layer.borderColor = UIColor.systemRed.cgColor
        return button
    }()
    
    private var childCounter: Int = 0 {
        didSet {
            if childCounter > 4 {
                addChildButton.isHidden = true
            } else {
                addChildButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}

private extension PesonalDataViewController {
    func initialConfigure() {
        configureScrollView()
        configurePersonalDataLabel()
        configurePersonalDataView()
        configureAddChildButton()
        configureChildLabel()
        configureStackView()
        configureCleanButton()
        addGestureRecognizers()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        var safeAreaTop: CGFloat = 0.0
        for scene in UIApplication.shared.connectedScenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows {
                    if window.isKeyWindow {
                        safeAreaTop = window.safeAreaInsets.top
                    }
                }
            }
        }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: safeAreaTop + 15),
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    func configurePersonalDataLabel() {
        scrollView.addSubview(personalDataLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: personalDataLabel, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: personalDataLabel, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: personalDataLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15)
        ])
        
    }
    
    func configurePersonalDataView() {
        scrollView.addSubview(personalDataView)
        
        personalDataView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: personalDataView, attribute: .top, relatedBy: .equal, toItem: personalDataLabel, attribute: .bottom, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: personalDataView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: personalDataView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15)
        ])
    }
    
    func configureAddChildButton() {
        scrollView.addSubview(addChildButton)
        
        addChildButton.addTarget(self, action: #selector(addChildData), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: addChildButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: addChildButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: addChildButton, attribute: .top, relatedBy: .equal, toItem: personalDataView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: addChildButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15)
        ])
        
        addChildButton.layer.cornerRadius = 50 / 2
    }
    
    func configureChildLabel() {
        scrollView.addSubview(childLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: childLabel, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: childLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: childLabel, attribute: .centerY, relatedBy: .equal, toItem: addChildButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    func configureStackView() {
        scrollView.addSubview(childStackView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: childStackView, attribute: .top, relatedBy: .equal, toItem: addChildButton, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: childStackView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: childStackView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15)
        ])
    }
    
    func configureCleanButton() {
        scrollView.addSubview(cleanButton)
        
        cleanButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: cleanButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: cleanButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: cleanButton, attribute: .top, relatedBy: .equal, toItem: childStackView, attribute: .bottom, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: cleanButton, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cleanButton, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        
        cleanButton.layer.cornerRadius = 50 / 2
    }
    
    func addGestureRecognizers() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @objc func addChildData() {
        childCounter += 1
        let childDataView = ChildDataView()
        if childCounter < 2 {
            childDataView.hideSeparator()
        }
        childDataView.delegate = self
        childStackView.addArrangedSubview(childDataView)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: AppText.cleanAlertTitle,
                                      message: AppText.cleanAlertMessage,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: AppText.cleanAlertCancelTitle,
                                      style: .cancel,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: AppText.cleanAlertConfirmTitle,
                                      style: .destructive,
                                      handler: { [weak self] _ in
            self?.cleanData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 5, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
    
    func cleanData() {
        childCounter = 0
        personalDataView.cleanData()
        childStackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}

extension PesonalDataViewController: ChildDataViewDelegate {
    func removeChildDataView() {
        childCounter -= 1
        
        if let view = childStackView.arrangedSubviews.first as? ChildDataView {
            view.hideSeparator()
        }
    }
}
