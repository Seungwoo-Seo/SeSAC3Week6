//
//  Example1ViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

class Example1ViewController: UIViewController {

    private let grayView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray

        return view
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "제목을 입력해주세요"

        return textField
    }()

    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "날짜를 입력해주세요"

        return textField
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.setContentHuggingPriority(.defaultLow, for: .vertical)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttributes()
        configureHierarchy()
    }

}

extension Example1ViewController {

    func configureRootView() {
        view.backgroundColor = .systemBackground
    }

    func configureAttributes() {
        configureRootView()
    }

    func configureHierarchy() {
        [
            grayView,
            titleTextField,
            dateTextField,
            descriptionTextView
        ].forEach { view.addSubview($0) }

        let inset: CGFloat = 40
        let spacing: CGFloat = 20

        grayView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(inset)
            make.height.equalToSuperview().multipliedBy(0.3)
        }

        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(spacing)
            make.horizontalEdges.equalToSuperview().inset(inset)
        }

        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(spacing)
            make.horizontalEdges.equalToSuperview().inset(inset)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(spacing)
            make.horizontalEdges.equalToSuperview().inset(inset)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
