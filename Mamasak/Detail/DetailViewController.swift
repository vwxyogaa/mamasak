//
//  DetailViewController.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class DetailViewController: UIViewController {
  var recipeId: Int = 0
  
  // MARK: - Views
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  lazy var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  
  lazy var editButton: UIBarButtonItem = {
    let editButton = UIBarButtonItem(
      title: "Edit Recipe",
      style: .plain,
      target: self,
      action: #selector(self.editButtonTapped(_:))
    )
    return editButton
  }()
  
  lazy var photoImageView: UIImageView = {
    let photoImageView = UIImageView()
    photoImageView.contentMode = .scaleAspectFill
    photoImageView.clipsToBounds = true
    return photoImageView
  }()
  
  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    return nameLabel
  }()
  
  lazy var ingredientsLabel: UILabel = {
    let ingredientsLabel = UILabel()
    ingredientsLabel.text = "Ingredients"
    ingredientsLabel.textColor = .black
    ingredientsLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return ingredientsLabel
  }()
  
  lazy var ingredientsTextView: UITextView = {
    let ingredientsTextView = UITextView()
    ingredientsTextView.isEditable = false
    ingredientsTextView.isScrollEnabled = false
    ingredientsTextView.backgroundColor = .clear
    ingredientsTextView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    ingredientsTextView.textColor = .black
    ingredientsTextView.tintColor = .black
    return ingredientsTextView
  }()
  
  lazy var cookingStepsLabel: UILabel = {
    let cookingStepsLabel = UILabel()
    cookingStepsLabel.text = "Cooking Steps"
    cookingStepsLabel.textColor = .black
    cookingStepsLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return cookingStepsLabel
  }()
  
  lazy var cookingStepsTextView: UITextView = {
    let cookingStepsTextView = UITextView()
    cookingStepsTextView.isEditable = false
    cookingStepsTextView.isScrollEnabled = false
    cookingStepsTextView.backgroundColor = .clear
    cookingStepsTextView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    cookingStepsTextView.textColor = .black
    cookingStepsTextView.tintColor = .black
    return cookingStepsTextView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupScrollView()
    setupContentView()
    setupEditButton()
    setupPhotoImageView()
    setupNameLabel()
    setupIngredientsLabel()
    setupIngredientsTextView()
    setupCookingStepsLabel()
    setupCookingStepsTextView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadRecipes()
  }
  
  // MARK: - Helpers
  func loadRecipes() {
    RecipeProvider.shared.getRecipe(recipeId) { recipes in
      DispatchQueue.main.async {
        if let photo = recipes.photo {
          self.photoImageView.image = UIImage(data: photo)
        }
        self.nameLabel.text = recipes.name
        self.ingredientsTextView.text = recipes.ingredients
        self.cookingStepsTextView.text = recipes.cookingSteps
      }
    }
  }
  
  private func setupViews() {
    view.backgroundColor = .white
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = .color1
  }
  
  private func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func setupContentView() {
    scrollView.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }
  
  private func setupEditButton() {
    navigationItem.rightBarButtonItem = editButton
  }
  
  private func setupPhotoImageView() {
    contentView.addSubview(photoImageView)
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 0.8),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      photoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor)
    ])
  }
  
  private func setupNameLabel() {
    contentView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupIngredientsLabel() {
    contentView.addSubview(ingredientsLabel)
    ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      ingredientsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupIngredientsTextView() {
    contentView.addSubview(ingredientsTextView)
    ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ingredientsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      ingredientsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      ingredientsTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor)
    ])
  }
  
  private func setupCookingStepsLabel() {
    contentView.addSubview(cookingStepsLabel)
    cookingStepsLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cookingStepsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cookingStepsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cookingStepsLabel.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupCookingStepsTextView() {
    contentView.addSubview(cookingStepsTextView)
    cookingStepsTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cookingStepsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cookingStepsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cookingStepsTextView.topAnchor.constraint(equalTo: cookingStepsLabel.bottomAnchor),
      cookingStepsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
  }
  
  // MARK: - Actions
  @objc private func editButtonTapped(_ sender: Any) {
    guard let name = nameLabel.text else { return }
    let alert = UIAlertController(title: "Warning", message: """
                                  Do you want to edit this recipe?
                                  Recipe name: \(name)
                                  """, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
      let viewController = AddRecipeViewController()
      viewController.recipeId = self.recipeId
      self.navigationController?.pushViewController(viewController, animated: true)
    })
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
