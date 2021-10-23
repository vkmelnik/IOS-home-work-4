//
//  ViewController.swift
//  vkmelnikPW4
//
//  Created by Vsevolod Melnik on 21.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var notes: [Note] = [] {
        didSet {
            emptyCollectionLabel.isHidden = notes.count != 0
        }
    }
    
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "CoreDataNotes")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Container loading failed")
            }
        }
        return container.viewContext
    }()
    
    @IBOutlet weak var emptyCollectionLabel: UILabel!
    @IBOutlet weak var notesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loadData()
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(createNote(sender:)))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notesCollectionView.reloadData()
    }
    
    func loadData() {
        if let notes = try? context.fetch(Note.fetchRequest()) as? [Note] {
            self.notes = notes.sorted(by:
                                        { $0.creationDate.compare($1.creationDate) == .orderedDescending })
        } else {
            self.notes = []
        }
    }
    
    func saveChanges() {
        if context.hasChanges {
            try? context.save()
        }
        if let notes = try? context.fetch(Note.fetchRequest()) as? [Note] {
            self.notes = notes
        } else {
            self.notes = []
        }
    }

    @objc func createNote(sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(
                withIdentifier: "NoteViewController") as? NoteViewController
        else {
            return
        }
        vc.outputVC = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func createLinkedNote(note: Note) {
        guard let vc = storyboard?.instantiateViewController(
                withIdentifier: "NoteViewController") as? NoteViewController
        else {
            return
        }
        vc.outputVC = self
        vc.noteLink = note
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.descriptionLabel.text = note.descriptionText
        if (note.linkToNote != nil) {
            cell.NoteSubCell.isHidden = false
            cell.NoteSubCell.titleLabel!.text = note.linkToNote!.title
            cell.NoteSubCell.descriptionLabel!.text = note.linkToNote!.descriptionText
        } else {
            cell.NoteSubCell.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(indexPath.row)" as NSString
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: .none) { _ in
            let deleteAction = UIAction(
                                        title: "Delete",
                                        image: UIImage(systemName: "trash"),
                                        attributes: UIMenuElement.Attributes.destructive) { value in
                self.context.delete(self.notes[indexPath.row])
                self.saveChanges()
                collectionView.reloadData()
            }
            let createLinkedAction = UIAction(
                                        title: "Create linked note",
                                        image: UIImage(systemName: "arrowshape.zigzag.right")) { value in
                self.createLinkedNote(note: self.notes[indexPath.row])
            }
            return UIMenu(title: "", image: nil, children: [createLinkedAction, deleteAction])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if ((notes[indexPath.row].linkToNote) != nil) {
            return CGSize(width: view.frame.width - 20, height: 170.0)
        } else {
            return CGSize(width: view.frame.width - 20, height: 110.0)
        }
    }
    
}
