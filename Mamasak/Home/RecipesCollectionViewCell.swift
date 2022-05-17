//
//  RecipesCollectionViewCell.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
  // MARK: - Views
  lazy var containerView: UIView = {
    let containerView = UIView()
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor.systemGray6.cgColor
    containerView.backgroundColor = .clear
    containerView.layer.cornerRadius = 15
    containerView.layer.masksToBounds = true
    return containerView
  }()
  
  lazy var photoImageView: UIImageView = {
    let photoImageView = UIImageView()
    photoImageView.backgroundColor = .gray
    photoImageView.contentMode = .scaleAspectFill
    photoImageView.layer.cornerRadius = 15
    photoImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    photoImageView.layer.masksToBounds = true
    return photoImageView
  }()
  
  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    return nameLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupContainerView()
    setupPhotoImageView()
    setupNameLabel()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupContainerView()
    setupPhotoImageView()
    setupNameLabel()
  }
  
  // MARK: - Helpers
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  private func setupPhotoImageView() {
    containerView.addSubview(photoImageView)
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoImageView.heightAnchor.constraint(equalToConstant: 176),
      photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
    ])
  }
  
  private func setupNameLabel() {
    containerView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
      nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
    ])
  }
}
