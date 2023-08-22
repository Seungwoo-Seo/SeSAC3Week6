//
//  Example3TableViewImageCell.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/23.
//

import SnapKit
import UIKit

final class Example3TableViewImageCell: UITableViewCell {
    static let identifier = "Example3TableViewImageCell"

    private let messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureAttributes()
        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ image: UIImage?) {
        messageImageView.image = image
    }

}

extension Example3TableViewImageCell {

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
        contentView.addSubview(messageImageView)

        let spacing: CGFloat = 8
        let inset: CGFloat = 16
        messageImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(spacing)
            make.leading.equalToSuperview().inset(inset)
        }
    }

}
