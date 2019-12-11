//
//  ProjectsCollectionViewController.swift
//  Kai
//
//  Created by Matthew Sanford on 12/9/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProjectCollectionViewCell"

class ProjectsCollectionViewController: UICollectionViewController {

    private var dataManager = ProjectDataManager.shared
    private var projects = [Project]()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        projects = dataManager.getAllProjects()
    }

    func printProjects() {
        for (i, project) in projects.enumerated() {
            let designs = project.designs as! Set<Design>
            for (j, design) in designs.enumerated(){
                print("Section [\(i)] \(project.name) -  Row [\(j)]\(design.name)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        collectionView.collectionViewLayout = createLayout()
        collectionView.allowsMultipleSelection = false
        let headerNib = UINib(nibName: "ProjectSectionHeaderView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: "header", withReuseIdentifier: "ProjectSectionHeaderView")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let nib = UINib(nibName: "ProjectCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        setupNavBar()
        collectionView.reloadData()
    }

    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewProject(_:)))
    }

    @objc private func createNewProject(_ sender: UIBarButtonItem) {
        let storyboard : UIStoryboard = UIStoryboard(name: "NewProjectPopover", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewProjectPopOverViewController") as! NewProjectPopOverViewController
        vc.delegate = self
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        present(vc, animated: true, completion:nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DesignViewController
        guard let indexPath = sender as? IndexPath else { return }
        let design = designForIndexPath(indexPath)
        destination.design = design
        
    }


    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)



        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)


        let headerSize = NSCollectionLayoutSize(widthDimension: .estimated(0.2), heightDimension: .estimated(44))


        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: NSRectAlignment.topLeading)
        header.pinToVisibleBounds = true

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = CGFloat(0)
        section.boundarySupplementaryItems = [header]

        return UICollectionViewCompositionalLayout(section: section)
    }

    func designForIndexPath(_ indexPath: IndexPath) -> Design? {
        guard let set = projects[indexPath.section].designs as? Set<Design> else { return nil }
        let designs = Array(set).sorted(by: {$0.name < $1.name })
        return designs[indexPath.row]
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return projects.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return projects[section].designs.count        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProjectCollectionViewCell
        guard let design = designForIndexPath(indexPath) else { return UICollectionViewCell() }
        cell.designNameLabel.text = design.name
        cell.lastOpenedLabel.text = design.lastAccessedAsString
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openDesign", sender: indexPath)
    }


    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProjectSectionHeaderView", for: indexPath) as? ProjectSectionHeaderView {
            header.projectNameLabel.text = projects[indexPath.section].name
            header.delegate = self
            return header
        }

        let header = ProjectSectionHeaderView(frame: .zero)
        header.projectNameLabel.text = projects[indexPath.section].name
        return header
    }


}

extension ProjectsCollectionViewController: ProjectSectionHeaderViewDelegate {
    func newDesignButtonWasPressed(_ projectName: String) {
        let alertController = UIAlertController(title: "New Design", message: "Enter your new design name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Design Name"
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController,
                let textField = alertController.textFields?.first else { return }

            guard let project = self.projects.first(where: { $0.name == projectName }),
                let text = textField.text else { return }
            ProjectDataManager.shared.createNewDesign(project, designName: text)
            self.collectionView.reloadData()
        }
        alertController.addAction(confirmAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension ProjectsCollectionViewController: NewProjectPopOverViewControllerDelegate {
    func savedProject() {
        projects = dataManager.getAllProjects()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }


}
