//
//  Example2ViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

final class Example2ViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "icecream")

        return imageView
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 18),
            scale: .large
        )
        let image = UIImage(
            systemName: "xmark",
            withConfiguration: largeConfig
        )
        button.setImage(image, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTapBackButton),
            for: .touchUpInside
        )

        return button
    }()

    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8

        return stackView
    }()
    private lazy var giftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white

        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 20),
            scale: .large
        )
        let image = UIImage(
            systemName: "gift.circle",
            withConfiguration: largeConfig
        )
        button.setImage(image, for: .normal)

        return button
    }()
    private lazy var diceButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white

        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 20),
            scale: .large
        )
        let image = UIImage(
            systemName: "circle.grid.3x3.circle",
            withConfiguration: largeConfig
        )
        button.setImage(image, for: .normal)

        return button
    }()
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white

        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 20),
            scale: .large
        )
        let image = UIImage(
            systemName: "gearshape.circle",
            withConfiguration: largeConfig
        )
        button.setImage(image, for: .normal)

        return button
    }()

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(named: "churros")
        imageView.clipsToBounds = true

        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "서승우"

        return label
    }()

    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0

        return stackView
    }()
    private lazy var chattingButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 16

        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 14)
        )
        let image = UIImage(
            systemName: "message.fill",
            withConfiguration: largeConfig
        )
        config.image = image

        var attString = AttributedString("나와의 채팅")
        attString.font = .systemFont(ofSize: 15, weight: .regular)
        config.attributedTitle = attString

        let button = UIButton(configuration: config)

        return button
    }()
    private lazy var profileEditButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 16

        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 14)
        )
        let image = UIImage(
            systemName: "pencil",
            withConfiguration: largeConfig
        )
        config.image = image

        var attString = AttributedString("프로필 편집")
        attString.font = .systemFont(ofSize: 15, weight: .regular)
        config.attributedTitle = attString

        let button = UIButton(configuration: config)

        return button
    }()
    private lazy var kakaoStoryButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 16

        let largeConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 14)
        )
        let image = UIImage(
            systemName: "quote.closing",
            withConfiguration: largeConfig
        )
        config.image = image

        var attString = AttributedString("카카오스토리")
        attString.font = .systemFont(ofSize: 15, weight: .regular)
        config.attributedTitle = attString


        let button = UIButton(configuration: config)

        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension Example2ViewController {

    func configureHierarchy() {
        [
            backgroundImageView,
            backButton,
            topStackView,
            containerView
        ].forEach { view.addSubview($0) }

        [giftButton, diceButton, settingButton].forEach { topStackView.addArrangedSubview($0) }

        [profileImageView, nameLabel, seperatorView, bottomStackView].forEach { containerView.addSubview($0) }

        [chattingButton, profileEditButton, kakaoStoryButton].forEach { bottomStackView.addArrangedSubview($0) }

        let spacing: CGFloat = 16
        let inset: CGFloat = 8
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.leading.equalToSuperview().inset(inset)
        }

        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.trailing.equalToSuperview().inset(inset)
        }

        containerView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset * 3)
        }

        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(spacing)
            make.centerX.equalToSuperview()
        }

        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(spacing * 2)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }

        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(spacing)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension Example2ViewController {

    @objc
    func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
