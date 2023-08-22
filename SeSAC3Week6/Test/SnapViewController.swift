//
//  SnapViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

/*
 addSubView
 superView
 offset, inset
 RTL - 현지화 할 때 아랍권은 반대니까 leading trailing이 반대로 적용이 되지만 left, right는 적용이 되질 않음
 */

class SnapViewController: UIViewController {
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        redView.backgroundColor = .red
        whiteView.backgroundColor = .white
        blueView.backgroundColor = .blue
        yellowView.backgroundColor = .yellow

        [redView, whiteView, blueView, yellowView].forEach { view.addSubview($0) }

        redView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }

        whiteView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(20)
        }

        blueView.snp.makeConstraints { make in
            make.edges.equalTo(whiteView).inset(20)
        }

        yellowView.snp.makeConstraints { make in
            make.edges.equalTo(blueView).inset(20)
        }
    }

}
