//
//  ContainerView.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/23.
//

import UIKit

protocol ContainerViewDelegate: AnyObject {
    func didTapReloadButton(_ sender: UIButton)
}

final class ContainerView: UIView {
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.text = "8월 22일 19시 16분"
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.text = "서울, 문래동"

        return label
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0

        return stackView
    }()

    private lazy var shareButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "square.and.arrow.up")

        let button = UIButton(configuration: config)

        return button
    }()

    private lazy var reloadButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "arrow.clockwise")

        let button = UIButton(configuration: config)
        button.addTarget(
            self,
            action: #selector(didTapReloadButton),
            for: .touchUpInside
        )

        return button
    }()

    weak var delegate: ContainerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ContainerView {

    func configureHierarchy() {
        [
            dateLabel,
            locationLabel,
            buttonStackView
        ].forEach { addSubview($0) }

        [
            shareButton,
            reloadButton
        ].forEach { buttonStackView.addArrangedSubview($0) }

        let spacing: CGFloat = 16
        let inset: CGFloat = 8
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(spacing)
            make.horizontalEdges.equalToSuperview().inset(inset)
        }

        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(spacing)
            make.leading.equalToSuperview().inset(inset)
            make.trailing.lessThanOrEqualTo(buttonStackView.snp.leading).inset(inset)
            make.bottom.equalToSuperview().inset(inset)
        }

        buttonStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(locationLabel)
            make.trailing.equalToSuperview()
        }
    }

}

extension ContainerView {

    @objc
    func didTapReloadButton(_ sender: UIButton) {
        delegate?.didTapReloadButton(sender)
    }

}
