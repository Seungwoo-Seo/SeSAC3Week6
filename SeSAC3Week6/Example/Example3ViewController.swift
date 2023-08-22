//
//  Example3ViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

/* 
final class TableViewHeaderView: UIView {
    private  var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.text = "8월 22일 19시 16분"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//        label.snp.makeConstraints {
//            $0.height.equalTo(50)
//        }
        print(label.frame)
        return label
    }()

    private  var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.text = "서울, 문래동"
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        return label
    }()

    private lazy var buttonStackView: UIStackView = {
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

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension TableViewHeaderView {

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
            make.bottom.equalToSuperview().inset(inset)
        }
//
//        buttonStackView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(locationLabel)
//            make.leading.equalTo(locationLabel.snp.trailing).offset(inset)
//            make.trailing.equalToSuperview().inset(inset)
//        }
    }

}
*/


final class Example3ViewController: UIViewController {
    // MARK: - View
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "icecream")

        return imageView
    }()

    private lazy var containerView: ContainerView = {
        let view = ContainerView(frame: .zero)
        view.backgroundColor = .clear
        view.delegate = self

        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(Example3TableViewTextCell.self, forCellReuseIdentifier: Example3TableViewTextCell.identifier)
        tableView.register(Example3TableViewImageCell.self, forCellReuseIdentifier: Example3TableViewImageCell.identifier)

        return tableView
    }()

    // MARK: - Data
    private var index = 0
    private var list: [Any] = [
        "오늘도 행복한 하루 보내세요",
        UIImage(named: "churros") ?? UIImage(),
        "1m/s의 바람이 불어요",
        "78%만큼 습해요",
        "지금은 9도에요"
    ]
    private var reverseList: [Any] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension Example3ViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return reverseList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let reverseRow = reverseList[indexPath.row]

        if let image = reverseRow as? UIImage {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Example3TableViewImageCell.identifier,
                for: indexPath
            ) as? Example3TableViewImageCell

            cell?.bind(image)

            return cell ?? UITableViewCell()

        } else if let text = reverseRow as? String {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Example3TableViewTextCell.identifier,
                for: indexPath
            ) as? Example3TableViewTextCell

            cell?.bind(text)

            return cell ?? UITableViewCell()

        } else {
            return UITableViewCell()
        }
    }

}

extension Example3ViewController: ContainerViewDelegate {

    func didTapReloadButton(_ sender: UIButton) {
        if index == list.count {
            index = 0
            reverseList.removeAll()
        }
        let row = list[index]
        reverseList.insert(row, at: 0)
        index += 1

        tableView.reloadData()
    }

}

extension Example3ViewController {

    func configureHierarchy() {
        [backgroundImageView, containerView, tableView].forEach { view.addSubview($0) }

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}


