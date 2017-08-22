//
//  ExerciseViewController.swift
//  Glooie
//
//  Created by Mykhailo Herasimov on 3/9/17.
//  Copyright © 2017 Mykhailo Herasimov. All rights reserved.
//

import UIKit
import CoreData

class ExerciseViewController: UITableViewController {
    
    fileprivate let brain = DataModelManager.shared
    
    var fetchedResultsController: NSFetchedResultsController<Exercise>!
    
    fileprivate let emptyViewTitleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isHidden = true
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "To create new exercise press ＋ in right hand corner"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin)
        return label
    }()
    
    func validateUI() {
        
        guard let numberOfRows = fetchedResultsController.sections?.first?.numberOfObjects else { return }
        
        emptyViewTitleLabel.isHidden = numberOfRows > 0
    }
    
    func configureEmptyView() {
        
        view.addSubview(emptyViewTitleLabel)
        
        NSLayoutConstraint.activate([
            
            emptyViewTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            emptyViewTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyViewTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    func initializeFetchedResultsController() {
        
        let request = NSFetchRequest<Exercise>(entityName: "Exercise")
        let dateCreationSort = NSSortDescriptor(key: "dateOfCreation", ascending: true)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [dateCreationSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: brain.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.leftBarButtonItem = editButtonItem
        
        initializeFetchedResultsController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureEmptyView()
        validateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? String() {
            
        case Segues.exerciseDescription.rawValue:
            if let vc = segue.destination as? ExerciseDescriptionViewController,
                let view = sender as? UIView,
                let indexPath = tableView.indexPath(for: view),
                let exercise = fetchedResultsController?.object(at: indexPath)
                    {
                
                let backItem = UIBarButtonItem()
                backItem.title = "Back"
                backItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white as Any], for: .normal)
                navigationItem.backBarButtonItem = backItem
                
                vc.exerciseDescription = exercise.exerciseDescription
            }
        default:
            break
        }
    }
}

extension ExerciseViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
        validateUI()
    }
}

extension ExerciseViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let exercise = fetchedResultsController?.object(at: indexPath),
           let animations = exercise.animations?.allObjects as? [Animation]
            {
            brain.userSelected(exercise: exercise, with: animations.sorted(by: { $0.position < $1.position }))
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        
        case .delete:
            
            if let exercise = fetchedResultsController?.object(at: indexPath) {
                
                brain.remove(exercise: exercise)
            }
        default:
            break
        }
    }
}

extension ExerciseViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRows = fetchedResultsController.sections?.first?.numberOfObjects else {
            
            return 0
        }
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.exerciseCell.rawValue, for: indexPath) as? ExerciseDescriptionTableViewCell,
           let exercise = fetchedResultsController?.object(at: indexPath) {
        
            cell.exercise = exercise
            return cell
        }
        
        return UITableViewCell()
    }
}

