//
//  ProfileTableViewCell.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//

import UIKit
import Kingfisher

final class ProfileTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let numberUser: UILabel = {
        let label = UILabel()
        label.font = .regular15
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameUser: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .bold22
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let userRating: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .bold22
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let photoUser: UIImageView = {
        let image = UIImageView()
        let placeholderImage = UIImage(systemName: "person.crop.circle.fill")
        let imageWithColor = placeholderImage?.withTintColor(
            A.Colors.gray.color,
            renderingMode: .alwaysOriginal)
        image.image = imageWithColor
        image.layer.cornerRadius = 14
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    // MARK: - Public properties
    var viewModel: ProfileCellViewModelProtocol? {
        didSet {
            nameUser.text = viewModel?.profileName
            userRating.text = viewModel?.rating
            numberUser.text = viewModel?.numberUser
            photoUser.kf.setImage(with: URL(string: viewModel?.profileImage ?? ""))
        }
    }
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = A.Colors.whiteDynamic.color
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private methods
    private func addSubviews() {
        contentView.addSubview(containerView)
        contentView.addSubview(numberUser)
        containerView.addSubview(photoUser)
        containerView.addSubview(nameUser)
        containerView.addSubview(userRating)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4),
            containerView.leadingAnchor.constraint(equalTo: numberUser.trailingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            numberUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            numberUser.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoUser.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            photoUser.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            photoUser.heightAnchor.constraint(equalToConstant: 28),
            photoUser.widthAnchor.constraint(equalToConstant: 28),
            nameUser.leadingAnchor.constraint(equalTo: photoUser.trailingAnchor, constant: 8),
            nameUser.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            userRating.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            userRating.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
}
