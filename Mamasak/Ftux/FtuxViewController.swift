//
//  FtuxViewController.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class FtuxViewController: UIViewController {
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var effectBackground: UIView = {
    let effectBackground = UIView()
    effectBackground.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return effectBackground
  }()
  
  lazy var startButton: PrimaryButton = {
    let startButton = PrimaryButton()
    startButton.setTitle("Start cooking", for: .normal)
    return startButton
  }()
  
  lazy var subtitleLabel: UILabel = {
    let subtitleLabel = UILabel()
    subtitleLabel.text = "Find best recipes for cooking"
    subtitleLabel.textAlignment = .center
    subtitleLabel.textColor = .white
    subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    return subtitleLabel
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "Let's\nCooking"
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 2
    titleLabel.textColor = .white
    titleLabel.font = UIFont.systemFont(ofSize: 56, weight: .bold)
    return titleLabel
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBackgroundImage()
    setupEffectBackground()
    setupStartButton()
    setupSubtitleLabel()
    setupTitleLabel()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - Helpers
  private func setupBackgroundImage() {
    view.addSubview(backgroundImage)
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupEffectBackground() {
    view.addSubview(effectBackground)
    effectBackground.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      effectBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      effectBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      effectBackground.topAnchor.constraint(equalTo: view.topAnchor),
      effectBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupStartButton() {
    view.addSubview(startButton)
    startButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      startButton.heightAnchor.constraint(equalToConstant: 54),
      startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -58)
    ])
    startButton.addTarget(self, action: #selector(self.startButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupSubtitleLabel() {
    view.addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      subtitleLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -40)
    ])
  }
  
  private func setupTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -24)
    ])
  }
  
  // MARK: - Actions
  @objc private func startButtonTapped(_ sender: Any) {
    let viewController = HomeViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    let window = view.window?.windowScene?.keyWindow
    window?.rootViewController = navigationController
  }
}
