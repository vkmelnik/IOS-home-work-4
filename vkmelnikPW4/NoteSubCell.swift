//
//  NoteSubCell.swift
//  vkmelnikPW4
//
//  Created by Vsevolod Melnik on 23.10.2021.
//

import UIKit

class NoteSubCell: UIView {
    
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 0.9466593585)
        self.layer.cornerRadius = 10
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 3
        titleLabel.font = UIFont.italicSystemFont(ofSize: 10)
        descriptionLabel.font = UIFont.italicSystemFont(ofSize: 9)
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        titleLabel.pinLeft(to: self, 5)
        titleLabel.pinRight(to: self, 5)
        titleLabel.pinTop(to: self, 5)
        titleLabel.setHeight(to: 10)
        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
        descriptionLabel.pinTop(to: titleLabel, 5)
        descriptionLabel.pinLeft(to: self, 5)
        descriptionLabel.pinRight(to: self, 5)
        descriptionLabel.pinBottom(to: self, 5)
        
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.layer.cornerRadius = 10
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 3
        titleLabel.font = UIFont.italicSystemFont(ofSize: 10)
        descriptionLabel.font = UIFont.italicSystemFont(ofSize: 9)
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        titleLabel.pinLeft(to: self, 5)
        titleLabel.pinRight(to: self, 5)
        titleLabel.pinTop(to: self, 5)
        titleLabel.setHeight(to: 10)
        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
        descriptionLabel.pinTop(to: titleLabel, 1)
        descriptionLabel.pinLeft(to: self, 5)
        descriptionLabel.pinRight(to: self, 5)
        descriptionLabel.pinBottom(to: self, 5)
        
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
