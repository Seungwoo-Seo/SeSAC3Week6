//
//  ViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/21.
//

import UIKit

// 1. 객체 얹이고, 레이아웃 잡고, 아웃렛 연결, 속성 조절
// 2. 뷰 객체 프로퍼티 선언(클래스 인스턴스 생성)
// 3. 명시적으로 루트뷰에 추가
// 4. 크기와 위치 정의
// 5. 속성 정의
// => AutoResizingMask, AutoLayout => 스토리보드 대응
// => AutoResizing과 AutoLayout을 같이 못쓴다.
// => NSLayoutConstraint => CodeBased 대응
    // 1. isActive
    // 2. addConstraints
// NSLayoutAnchor

class ViewController: UIViewController {

    let emailTextField = UITextField()
    let passwwordTextField = UITextField()
    let signButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(emailTextField)
        view.addSubview(passwwordTextField)

        // 옛날에 사용하던 방식 frame 방식
        // 아이폰이 한개였을 땐 레이아웃이 필요가 없었지만 점점 아이폰의 종류가 늘어나면서 frame이 한계가 생겼고
        // AutoResizingMask, AutoLayout이 등장
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)

        emailTextField.backgroundColor = .lightGray
        emailTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "닉네임을 입력해주세요."

//        NSLayoutConstraint(
//            item: passwwordTextField,
//            attribute: .leading,
//            relatedBy: .equal,
//            toItem: view.safeAreaLayoutGuide,
//            attribute: .leading,
//            multiplier: 1,
//            constant: 50
//        ).isActive = true
//
//        NSLayoutConstraint(
//            item: passwwordTextField,
//            attribute: .trailing,
//            relatedBy: .equal,
//            toItem: view.safeAreaLayoutGuide,
//            attribute: .trailing,
//            multiplier: 1,
//            constant: -50
//        ).isActive = true
//
//        NSLayoutConstraint(
//            item: passwwordTextField,
//            attribute: .top,
//            relatedBy: .equal,
//            toItem: view.safeAreaLayoutGuide,
//            attribute: .top,
//            multiplier: 1,
//            constant: 50
//        ).isActive = true
//
//        NSLayoutConstraint(
//            item: passwwordTextField,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .height,
//            multiplier: 1,
//            constant: 50
//        ).isActive = true

        // addConstraints
        let leading = NSLayoutConstraint(
            item: passwwordTextField,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .leading,
            multiplier: 1,
            constant: 50
        )

        let trailing = NSLayoutConstraint(
            item: passwwordTextField,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .trailing,
            multiplier: 1,
            constant: -50
        )

        let top = NSLayoutConstraint(
            item: passwwordTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 50
        )

        let height = NSLayoutConstraint(
            item: passwwordTextField,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: 50
        )
        view.addConstraints([leading, trailing, top, height])

        passwwordTextField.backgroundColor = .brown
        // autoResizing을 해제시킴
        passwwordTextField.translatesAutoresizingMaskIntoConstraints = false

        setLayoutAnchor()
    }

    @objc
    func didTapSignButton() {
        let vc = LocationViewController()
        present(vc, animated: true)
    }
    
    func setLayoutAnchor() {
        signButton.addTarget(self, action: #selector(didTapSignButton), for: .touchUpInside)

        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false

        signButton.backgroundColor = .orange

        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

