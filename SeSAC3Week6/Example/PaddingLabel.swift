//
//  PaddingLabel.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import UIKit

final class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(
        top: 16.0,
        left: 16.0,
        bottom: 16.0,
        right: 16.0
    )

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
