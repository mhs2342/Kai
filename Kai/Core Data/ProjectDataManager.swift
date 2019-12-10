//
//  ProjectDataManager.swift
//  Kai
//
//  Created by Matthew Sanford on 12/10/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import CoreData
import Foundation

class ProjectDataManager {
    let container = AppDelegate.persistentContainer
    let context: NSManagedObjectContext = AppDelegate.persistentContainer.viewContext
    private init() {}
    static let shared = ProjectDataManager()

    func createNewProject(_ projectName: String, _ designName: String) {
        let project = Project(context: context)
        project.name = projectName
        if let context = project.managedObjectContext {
            let design = Design(context: context)
            design.lastAccessed = Date()
            design.name = designName
            project.addToDesigns(design)
        }
        do {
            try context.save()
            print("Saved Project")
        } catch {
            print("Something went wrong \(error)")
        }

    }

    func createNewShape() -> Shape {
        let shape = Shape(context: context)
        return shape
    }

    func addShapeToDesign(_ shape: Shape, design: Design) {
        design.addToShapes(shape)
        shape.design = design

        do {
            try context.save()
            print("Shape Saved to Design")
        } catch {
            print("Something went wrong \(error)")
        }
    }

    func updateShape(_ design: Design, _ shape: Shape) {
        removeShapeFromDesign(shape, design)
        addShapeToDesign(shape, design: design)
    }

    func removeShapeFromDesign(_ shape: Shape, _ design: Design) {
        design.removeFromShapes(shape)
        do {
            try context.save()
            print("Shape Removed to Design")
        } catch {
            print("Something went wrong \(error)")
        }
    }

    func addDesignItem(_ item: DesignTrayShapeItemModel, design: Design) {
        let customItem = CustomDesignItem(context: context)
        customItem.name = item.name
        customItem.length = item.length ?? 0
        customItem.width = item.width ?? 0
        customItem.diameter = item.diameter ?? 0
        design.addToDesignItems(customItem)
        customItem.design = design

        do {
            try context.save()
            print("Save Design Item")
        } catch {
            print("Something went wrong \(error)")
        }
    }

    func getAllProjects() -> [Project] {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(request)
        } catch  {
            print(error)
        }
        return []
    }

}
