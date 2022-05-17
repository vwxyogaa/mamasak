//
//  AddRecipeViewController.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class AddRecipeViewController: UIViewController {
  var recipeId: Int = 0
  
  // MARK: - Views
  lazy var imagePicker: UIImagePickerController = {
    let imagePicker = UIImagePickerController()
    return imagePicker
  }()
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  lazy var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  
  lazy var addRecipeButton: UIBarButtonItem = {
    let addRecipeButton = UIBarButtonItem(
      title: "Add Recipe",
      style: .plain,
      target: self,
      action: #selector(self.addRecipeButtonTapped(_:))
    )
    addRecipeButton.tintColor = .color1
    return addRecipeButton
  }()
  
  lazy var cancelButton: UIBarButtonItem = {
    let cancelButton = UIBarButtonItem(
      title: "Cancel",
      style: .plain,
      target: self,
      action: #selector(self.cancelButtonTapped(_:))
    )
    cancelButton.tintColor = .color1
    return cancelButton
  }()
  
  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.text = "Name"
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    return nameLabel
  }()
  
  lazy var nameTextField: UITextField = {
    let nameTextField = UITextField()
    nameTextField.placeholder = "Enter your recipe name"
    nameTextField.backgroundColor = .clear
    nameTextField.layer.borderWidth = 1
    nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
    nameTextField.layer.cornerRadius = 5
    nameTextField.layer.masksToBounds = true
    nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: nameTextField.frame.height))
    nameTextField.leftViewMode = .always
    return nameTextField
  }()
  
  lazy var photoLabel: UILabel = {
    let photoLabel = UILabel()
    photoLabel.text = "Photo"
    photoLabel.textColor = .black
    photoLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    return photoLabel
  }()
  
  lazy var photoImageView: UIImageView = {
    let photoImageView = UIImageView()
    photoImageView.contentMode = .center
    photoImageView.layer.cornerRadius = 5
    photoImageView.layer.masksToBounds = true
    photoImageView.layer.borderWidth = 1
    photoImageView.image = UIImage(named: "dummyImage")
    photoImageView.layer.borderColor = UIColor.systemGray4.cgColor
    return photoImageView
  }()
  
  lazy var addPhotoButton: PrimaryButton = {
    let addPhotoButton = PrimaryButton()
    addPhotoButton.setTitle("Add Photo", for: .normal)
    return addPhotoButton
  }()
  
  lazy var ingredientsLabel: UILabel = {
    let ingredientsLabel = UILabel()
    ingredientsLabel.text = "Ingredients"
    ingredientsLabel.textColor = .black
    ingredientsLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    return ingredientsLabel
  }()
  
  lazy var ingredientsTextView: UITextView = {
    let ingredientsTextView = UITextView()
    ingredientsTextView.backgroundColor = .clear
    ingredientsTextView.layer.borderWidth = 1
    ingredientsTextView.layer.borderColor = UIColor.systemGray4.cgColor
    ingredientsTextView.layer.cornerRadius = 5
    ingredientsTextView.layer.masksToBounds = true
    ingredientsTextView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    ingredientsTextView.textColor = .black
    ingredientsTextView.tintColor = .black
    return ingredientsTextView
  }()
  
  lazy var cookingStepsLabel: UILabel = {
    let cookingStepsLabel = UILabel()
    cookingStepsLabel.text = "Cooking Steps"
    cookingStepsLabel.textColor = .black
    cookingStepsLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    return cookingStepsLabel
  }()
  
  lazy var cookingStepsTextView: UITextView = {
    let cookingStepsTextView = UITextView()
    cookingStepsTextView.backgroundColor = .clear
    cookingStepsTextView.layer.borderWidth = 1
    cookingStepsTextView.layer.borderColor = UIColor.systemGray4.cgColor
    cookingStepsTextView.layer.cornerRadius = 5
    cookingStepsTextView.layer.masksToBounds = true
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
    setupCancelButton()
    setupAddRecipeButton()
    setupNameLabel()
    setupNameTextField()
    setupPhotoLabel()
    setupPhotoImageView()
    setupImagePicker()
    setupAddPhotoButton()
    setupIngredientsLabel()
    setupIngredientsTextView()
    setupCookingStepsLabel()
    setupCookingStepsTextView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupForm()
  }
  
  // MARK: - Helpers
  private func setupForm() {
    if recipeId > 0 {
      title = "Edit Recipe"
      addRecipeButton.title = "Done"
      loadRecipes()
    } else {
      title = "Add New Recipe"
      addRecipeButton.title = "Create"
    }
  }
  
  private func loadRecipes() {
    RecipeProvider.shared.getRecipe(recipeId) { recipes in
      DispatchQueue.main.async {
        self.nameTextField.text = recipes.name
        if let photo = recipes.photo {
          self.photoImageView.image = UIImage(data: photo)
        }
        self.ingredientsTextView.text = recipes.ingredients
        self.cookingStepsTextView.text = recipes.cookingSteps
      }
    }
  }
  
  private func saveRecipe() {
    guard let name = nameTextField.text, name != "" else {
      alert("Field name is empty")
      return
    }
    
    guard let ingredients = ingredientsTextView.text, ingredients != "" else {
      alert("Field ingredients is empty")
      return
    }
    
    guard let cookingSteps = cookingStepsTextView.text, cookingSteps != "" else {
      alert("Field cookingSteps is empty")
      return
    }
    
    if let image = photoImageView.image, let data = image.pngData() as NSData? {
      if recipeId > 0 {
        RecipeProvider.shared.updateRecipe(
          recipeId,
          name,
          data as Data,
          ingredients,
          cookingSteps) {
            DispatchQueue.main.async {
              let alert = UIAlertController(title: "Successful", message: "Recipe updated.", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
              })
              self.present(alert, animated: true, completion: nil)
            }
          }
      } else {
        RecipeProvider.shared.createRecipe(
          name,
          data as Data,
          ingredients,
          cookingSteps) {
            DispatchQueue.main.async {
              let alert = UIAlertController(title: "Successful", message: "New recipe created.", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
              })
              self.present(alert, animated: true, completion: nil)
            }
          }
      }
    }
  }
  
  func alert(_ message: String) {
    let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(alertAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  private func setupViews() {
    title = "Add New Recipe"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .white
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
  
  private func setupCancelButton() {
    navigationItem.leftBarButtonItem = cancelButton
  }
  
  private func setupAddRecipeButton() {
    navigationItem.rightBarButtonItem = addRecipeButton
  }
  
  private func setupNameLabel() {
    contentView.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16)
    ])
  }
  
  private func setupNameTextField() {
    contentView.addSubview(nameTextField)
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameTextField.heightAnchor.constraint(equalToConstant: 44),
      nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2)
    ])
  }
  
  private func setupPhotoLabel() {
    contentView.addSubview(photoLabel)
    photoLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      photoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      photoLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupPhotoImageView() {
    contentView.addSubview(photoImageView)
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 0.5),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      photoImageView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 2)
    ])
  }
  
  private func setupImagePicker() {
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    imagePicker.sourceType = .photoLibrary
  }
  
  private func setupAddPhotoButton() {
    contentView.addSubview(addPhotoButton)
    addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addPhotoButton.heightAnchor.constraint(equalToConstant: 54),
      addPhotoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      addPhotoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      addPhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8)
    ])
    addPhotoButton.addTarget(self, action: #selector(self.addPhotoButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupIngredientsLabel() {
    contentView.addSubview(ingredientsLabel)
    ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      ingredientsLabel.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupIngredientsTextView() {
    contentView.addSubview(ingredientsTextView)
    ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ingredientsTextView.heightAnchor.constraint(equalTo: ingredientsTextView.widthAnchor, multiplier: 0.5),
      ingredientsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      ingredientsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      ingredientsTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 2)
    ])
  }
  
  private func setupCookingStepsLabel() {
    contentView.addSubview(cookingStepsLabel)
    cookingStepsLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cookingStepsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cookingStepsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cookingStepsLabel.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 16)
    ])
  }
  
  private func setupCookingStepsTextView() {
    contentView.addSubview(cookingStepsTextView)
    cookingStepsTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cookingStepsTextView.heightAnchor.constraint(equalTo: cookingStepsTextView.widthAnchor, multiplier: 0.8),
      cookingStepsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cookingStepsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cookingStepsTextView.topAnchor.constraint(equalTo: cookingStepsLabel.bottomAnchor, constant: 2),
      cookingStepsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
  }
  
  // MARK: - Actions
  @objc private func addPhotoButtonTapped(_ sender: Any) {
    self.present(imagePicker, animated: true, completion: nil)
  }
  
  @objc private func addRecipeButtonTapped(_ sender: Any) {
    saveRecipe()
  }
  
  @objc private func cancelButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}


extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      self.photoImageView.contentMode = .scaleToFill
      self.photoImageView.image = result
      dismiss(animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Failed", message: "Image can't be loaded.", preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
}
