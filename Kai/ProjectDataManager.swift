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
            print("saved")
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
