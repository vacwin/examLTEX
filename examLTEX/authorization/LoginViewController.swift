//
//  LoginViewController.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - properties
    final var onLogin: (() -> Void)?
    private var phoneCode: String?
    private var phoneMask: String?
    private var charToCompare: Character?
    //UI prop
    private var companyLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var enterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход в аккаунт"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    //first stack
    private var phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Телефон"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    private var eraseButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "xmark.circle.fill"),
            for: .normal
        )
        button.tintColor = #colorLiteral(red: 0.8117647767, green: 0.8117647767, blue: 0.8117647767, alpha: 1)
        return button
    }()
    private var phoneTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.keyboardType = .numberPad
        textField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        //text
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.smartInsertDeleteType = .no
        textField.smartDashesType = .no
        textField.smartQuotesType = .no
        textField.textColor = #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1)
        //border
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 14
        textField.layer.borderColor = #colorLiteral(red: 0.6196078658, green: 0.6196078658, blue: 0.6196078658, alpha: 1)
        textField.clipsToBounds = true
        return textField
    }()
    //second stack
    private var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var passwordTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.keyboardType = .asciiCapable
        textField.isSecureTextEntry = true
        textField.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0)
        //text
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.smartInsertDeleteType = .no
        textField.smartDashesType = .no
        textField.smartQuotesType = .no
        textField.textColor = #colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1)
        //border
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 14
        textField.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.9568627477, blue: 0.9568627477, alpha: 1)
        textField.clipsToBounds = true
        return textField
    }()
    private var toggleSecurityButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "eye"),
            for: .normal
        )
        button.tintColor = #colorLiteral(red: 0.6196078658, green: 0.6196078658, blue: 0.6196078658, alpha: 1)
        return button
    }()
    private var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tapDisabled()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    //MARK: - setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    private func setup() {
        self.setupConstraints()
        self.setupHideTap()
        self.getMask()
    }
    //MARK: - UI
    private func setupConstraints() {
        let safe = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(self.companyLogo)
        self.companyLogo.centerXAnchor.constraint(equalTo: safe.centerXAnchor).isActive = true
        self.companyLogo.topAnchor.constraint(equalTo: safe.topAnchor, constant: 36).isActive = true
        self.companyLogo.widthAnchor.constraint(equalToConstant: 130).isActive = true
        self.companyLogo.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        self.view.addSubview(self.enterLabel)
        self.enterLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16).isActive = true
        self.enterLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16).isActive = true
        self.enterLabel.topAnchor.constraint(equalTo: self.companyLogo.bottomAnchor, constant: 32).isActive = true
        self.enterLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.view.addSubview(self.phoneStackView)
        self.phoneStackView.leadingAnchor.constraint(equalTo: self.enterLabel.leadingAnchor).isActive = true
        self.phoneStackView.trailingAnchor.constraint(equalTo: self.enterLabel.trailingAnchor).isActive = true
        self.phoneStackView.topAnchor.constraint(equalTo: self.enterLabel.bottomAnchor, constant: 24).isActive = true
        self.setupPhoneStackView()
        
        self.view.addSubview(self.passwordStackView)
        self.passwordStackView.leadingAnchor.constraint(equalTo: self.phoneStackView.leadingAnchor).isActive = true
        self.passwordStackView.trailingAnchor.constraint(equalTo: self.phoneStackView.trailingAnchor).isActive = true
        self.passwordStackView.topAnchor.constraint(equalTo: self.phoneStackView.bottomAnchor, constant: 24).isActive = true
        self.setupPasswordStackView()
        
        self.view.addSubview(self.loginButton)
        self.loginButton.leadingAnchor.constraint(equalTo: self.passwordStackView.leadingAnchor).isActive = true
        self.loginButton.trailingAnchor.constraint(equalTo: self.passwordStackView.trailingAnchor).isActive = true
        self.loginButton.topAnchor.constraint(equalTo: self.passwordStackView.bottomAnchor, constant: 48).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.loginButton.addTarget(
            self,
            action: #selector(self.onLoginButton),
            for: .touchUpInside
        )
    }

    private func setupPhoneStackView() {
        self.phoneStackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.phoneStackView.addArrangedSubview(self.phoneLabel)
        self.phoneStackView.addArrangedSubview(self.phoneTextField)
        
        self.phoneTextField.becomeFirstResponder()
        self.phoneTextField.delegate = self
        self.phoneTextField.rightView = self.eraseButton
        self.phoneTextField.rightViewMode = .always
        self.eraseButton.addTarget(
            self,
            action: #selector(self.erasePhoneTextField),
            for: .touchUpInside
        )
    }
    
    private func setupPasswordStackView() {
        self.passwordStackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.passwordStackView.addArrangedSubview(self.passwordLabel)
        self.passwordStackView.addArrangedSubview(self.passwordTextField)
        
        self.passwordTextField.delegate = self
        self.passwordTextField.rightView = self.toggleSecurityButton
        self.passwordTextField.rightViewMode = .always
        self.passwordTextField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )
        self.toggleSecurityButton.addTarget(
            self,
            action: #selector(self.toggleSecureTextEntry),
            for: .touchUpInside
        )
    }
    
    private func setupHideTap() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.onTapSelfView)
        )
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    //MARK: - network
    private func getMask() {
        RequestManager.shared.getNetwork { network, error in
            guard
                let network,
                let phoneMask = network.phoneMask,
                let formattedPhone = PhoneMaskFormatter.split(phoneMask)
            else { return self.phoneTextField.placeholder = "" }
            self.phoneCode = formattedPhone.0
            self.phoneMask = formattedPhone.1
            self.charToCompare = formattedPhone.2
            DispatchQueue.main.async { [weak self] in
                self?.phoneTextField.text = formattedPhone.0
            }
        }
    }
    //MARK: - actions
    @objc private func onTapSelfView() {
        self.view.endEditing(true)
    }
    
    @objc private func onLoginButton() {
        guard
            let phone = self.phoneTextField.text,
            let password = self.passwordTextField.text
        else { return }
        RequestManager.shared.authenticateUser(with: phone.removePhoneChars, and: password) { authStatus, error in
            print(authStatus, error)
        }
        self.onLogin?()
    }
   
    @objc private func erasePhoneTextField() {
        self.phoneTextField.text = self.phoneCode
    }
    
    @objc private func toggleSecureTextEntry() {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count >= 1 {
            self.loginButton.tapAllowed()
        } else {
            self.loginButton.tapDisabled()
        }
    }
}
//MARK: - delegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneTextField {
            guard
                let text = textField.text,
                let phoneCode,
                let phoneMask,
                let charToCompare,
                let newRange = Range(range, in: text)
            else { return false }
            if range.location < phoneCode.count {
                return false
            }
            var digits = text.dropFirst(phoneCode.count).filter(\.isNumber)
            //deletion
            if string.isEmpty {
                if !digits.isEmpty {
                    digits.removeLast()
                }
            } else {
                let newText = text.replacingCharacters(in: newRange, with: string)
                digits = newText.dropFirst(phoneCode.count).filter(\.isNumber)
            }
            let formatted = PhoneMaskFormatter.format(digits, with: phoneMask, and: charToCompare)
            textField.text = phoneCode + formatted
            //focus next textField
            if digits.count == phoneMask.filter({ $0 == "Х" }).count {
                DispatchQueue.main.async {
                    self.passwordTextField.becomeFirstResponder()
                }
            }
            return false
        }
        
        if textField == self.passwordTextField {
            textField.sendActions(for: .editingChanged)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.phoneTextField {
            textField.layer.borderColor = #colorLiteral(red: 0.6196078658, green: 0.6196078658, blue: 0.6196078658, alpha: 1)
            if textField.text?.isEmpty ?? true, let phoneCode {
                textField.text = phoneCode
            }
        }
        
        if textField == self.passwordTextField {
            textField.layer.borderColor = #colorLiteral(red: 0.6196078658, green: 0.6196078658, blue: 0.6196078658, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.phoneTextField {
            textField.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.9568627477, blue: 0.9568627477, alpha: 1)
        }
        
        if textField == self.passwordTextField {
            textField.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.9568627477, blue: 0.9568627477, alpha: 1)
        }
    }
}

