//
//  ViewController.swift
//  vkmelnikPW4
//
//  Created by Vsevolod Melnik on 21.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emptyCollectionLabel: UILabel!
    @IBOutlet weak var notesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(createNote(sender:)))
        
    }

    @objc func createNote(sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier:"NoteViewController")
        else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.titleLabel.text = "Yeah"
        cell.descriptionLabel.text = "That's great"
        
        return cell
    }
    
}
