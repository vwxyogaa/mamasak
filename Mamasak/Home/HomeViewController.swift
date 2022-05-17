//
//  HomeViewController.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class HomeViewController: UIViewController {
  private var recipes: [RecipesModel] = []
  private var recipeId: Int = 0
  
  // MARK: - Views
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
  lazy var addButton: UIBarButtonItem = {
    let addButton = UIBarButtonItem(
      image: UIImage(systemName: "plus"),
      style: .plain,
      target: self,
      action: #selector(self.addButtonTapped(_:))
    )
    addButton.tintColor = .color1
    return addButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupAddButton()
    setupCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadRecipes()
  }
  
  // MARK: - Helpers
  private func loadRecipes() {
    RecipeProvider.shared.getAllRecipes { recipes in
      DispatchQueue.main.async {
        self.recipes = recipes
        self.collectionView.reloadData()
      }
    }
  }
  
  private func setupViews() {
    title = "Mamasak"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.backgroundColor = .white
  }
  
  private func setupAddButton() {
    navigationItem.rightBarButtonItem = addButton
  }
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    collectionView.register(RecipesCollectionViewCell.self, forCellWithReuseIdentifier: "recipesCellId")
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  // MARK: - Actions
  @objc private func addButtonTapped(_ sender: Any) {
    let viewController = AddRecipeViewController()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipesCellId", for: indexPath) as? RecipesCollectionViewCell {
      let data = recipes[indexPath.item]
      cell.nameLabel.text = data.name
      if let photo = data.photo {
        cell.photoImageView.image = UIImage(data: photo)
      }
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.recipeId = Int(recipes[indexPath.item].id ?? 0)
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 150, height: 240)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
