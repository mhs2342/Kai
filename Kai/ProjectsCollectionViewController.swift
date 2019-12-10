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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        collectionView.collectionViewLayout = createLayout()
        let headerNib = UINib(nibName: "ProjectSectionHeaderView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: "header", withReuseIdentifier: "ProjectSectionHeaderView")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let nib = UINib(nibName: "ProjectCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        setupNavBar()
        projects = dataManager.getAllProjects()
        collectionView.reloadData()
    }

    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewProject(_:)))
    }

    @objc private func createNewProject(_ sender: UIBarButtonItem) {
        let storyboard : UIStoryboard = UIStoryboard(name: "NewProjectPopover", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewProjectPopOverViewController")
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender
        present(vc, animated: true, completion:nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DesignViewController
        let selected = collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!) as! ProjectCollectionViewCell
        destination.title = selected.designNameLabel.text
    }


    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)



        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])


        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .estimated(44))


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
        guard let set = projects[indexPath.row].designs as? Set<Design> else { return nil }
        let designs = Array(set)
        return designs[indexPath.row]
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return projects.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return projects[section].designs?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProjectCollectionViewCell
        guard let set = projects[indexPath.row].designs as? Set<Design> else { return UICollectionViewCell() }
        let designs = Array(set)
        let design = designs[indexPath.row]
        cell.designNameLabel.text = design.name
        cell.lastOpenedLabel.text = design.lastAccessedAsString
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openDesign", sender: nil)
    }


    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }


    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProjectSectionHeaderView", for: indexPath) as? ProjectSectionHeaderView {
            header.projectNameLabel.text = projects[indexPath.section].name
            return header
        }

        let header = ProjectSectionHeaderView(frame: .zero)
        header.projectNameLabel.text = projects[indexPath.section].name
        return header
    }
}
