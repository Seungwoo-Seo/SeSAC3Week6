//
//  Example3TableViewTextCell.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

final class Example3TableViewTextCell: UITableViewCell {
    static let identifier = "Example3TableViewTextCell"

    private let paddingLabel: PaddingLabel = {
        let label = PaddingLabel(
            padding: UIEdgeInsets(
                top: 12,
                left: 12,
                bottom: 12,
                right: 12
            )
        )
        label.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
        label.textColor = .label
        label.backgroundColor = .white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true

        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        configureAttributes()
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ text: String) {
        paddingLabel.text = text
    }

}

extension Example3TableViewTextCell {

    func configureCell() {
        backgroundColor = .clear
    }

    func configureContentView() {
        contentView.backgroundColor = .clear
    }

    func configureAttributes() {
        configureCell()
        configureContentView()
    }

    func configureHierarchy() {
        contentView.addSubview(paddingLabel)

        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        paddingLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(spacing)
            make.leading.equalToSuperview().inset(inset)
        }
    }

}
