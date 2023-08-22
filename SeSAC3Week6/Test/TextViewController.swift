//
//  TextViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

class TextViewController: UIViewController {

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red

        return imageView
    }()
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "제목을 입력해주세요."
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 15)

        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension TextViewController {

    func configureHierarchy() {
        [photoImageView, titleTextField].forEach { view.addSubview($0) }

        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(view).multipliedBy(0.3)
        }

        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }

}
