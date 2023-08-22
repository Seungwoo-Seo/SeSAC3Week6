//
//  ExampleViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

final class ExampleViewController: UIViewController {

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    private lazy var button1: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("button1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(
            self,
            action: #selector(didTapButton1),
            for: .touchUpInside
        )

        return button
    }()

    private lazy var button2: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("button2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(
            self,
            action: #selector(didTapButton2),
            for: .touchUpInside
        )

        return button
    }()

    private lazy var button3: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("button3", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(
            self,
            action: #selector(didTapButton3),
            for: .touchUpInside
        )

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension ExampleViewController {

    func configureHierarchy() {
        view.addSubview(buttonStackView)

        [button1, button2, button3].forEach { buttonStackView.addArrangedSubview($0) }

        buttonStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}

extension ExampleViewController {

    @objc
    func didTapButton1(_ sender: UIButton) {
        let vc = Example1ViewController()
        present(vc, animated: true)
    }

    @objc
    func didTapButton2(_ sender: UIButton) {
        let vc = Example2ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    @objc
    func didTapButton3(_ sender: UIButton) {
        let vc = Example3ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

