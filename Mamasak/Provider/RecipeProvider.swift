//
//  RecipeProvider.swift
//  Mamasak
//
//  Created by yxgg on 13/05/22.
//

import Foundation
import CoreData
import UIKit

class RecipeProvider {
  static let shared: RecipeProvider = RecipeProvider()
  private init() { }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Mamasak")
    
    container.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Unresolved error \(error!)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = false
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil
    
    return container
  }()
  
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  func getAllRecipes(completion: @escaping(_ recipes: [RecipesModel]) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeData")
      do {
        let results = try taskContext.fetch(fetchRequest)
        var recipes: [RecipesModel] = []
        for result in results {
          let recipe = RecipesModel(
            id: result.value(forKeyPath: "id") as? Int64,
            name: result.value(forKeyPath: "name") as? String,
            photo: result.value(forKeyPath: "photo") as? Data,
            ingredients: result.value(forKeyPath: "ingredients") as? String,
            cookingSteps: result.value(forKeyPath: "cookingSteps") as? String
          )
          recipes.append(recipe)
        }
        completion(recipes)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func getRecipe(_ id: Int, completion: @escaping(_ recipes: RecipesModel) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      do {
        if let result = try taskContext.fetch(fetchRequest).first {
          let recipe = RecipesModel(
            id: result.value(forKeyPath: "id") as? Int64,
            name: result.value(forKeyPath: "name") as? String,
            photo: result.value(forKeyPath: "photo") as? Data,
            ingredients: result.value(forKeyPath: "ingredients") as? String,
            cookingSteps: result.value(forKeyPath: "cookingSteps") as? String
          )
          completion(recipe)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func createRecipe(
    _ name: String,
    _ photo: Data,
    _ ingredients: String,
    _ cookingSteps: String,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      if let entity = NSEntityDescription.entity(forEntityName: "RecipeData", in: taskContext) {
        let recipe = NSManagedObject(entity: entity, insertInto: taskContext)
        self.getMaxId { id in
          recipe.setValue(id+1, forKeyPath: "id")
          recipe.setValue(name, forKeyPath: "name")
          recipe.setValue(photo, forKeyPath: "photo")
          recipe.setValue(ingredients, forKeyPath: "ingredients")
          recipe.setValue(cookingSteps, forKeyPath: "cookingSteps")
          do {
            try taskContext.save()
            completion()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        }
      }
    }
  }
  
  func updateRecipe(
    _ id: Int,
    _ name: String,
    _ photo: Data,
    _ ingredients: String,
    _ cookingSteps: String,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      if let result = try? taskContext.fetch(fetchRequest), let recipe = result.first as? RecipeData {
        recipe.setValue(name, forKeyPath: "name")
        recipe.setValue(photo, forKeyPath: "photo")
        recipe.setValue(ingredients, forKeyPath: "ingredients")
        recipe.setValue(cookingSteps, forKeyPath: "cookingSteps")
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }
  
  func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeData")
      let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.fetchLimit = 1
      do {
        let lastRecipe = try taskContext.fetch(fetchRequest)
        if let recipe = lastRecipe.first, let position = recipe.value(forKeyPath: "id") as? Int{
          completion(position)
        } else {
          completion(0)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deleteAllRecipe(completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeData")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
  
  func deleteRecipe(_ id: Int, completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
}
