//
//  ContactTableViewCell.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit
import SDWebImage

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet var headingLabels: [UILabel]!
    @IBOutlet var descriptionLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class func reuseIdentifier() -> String
    {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contactImageView.image = nil
        for headingLabel in headingLabels {
            headingLabel.text = nil
        }
        
        for descriptionLabel in descriptionLabels {
            descriptionLabel.text = nil
        }
    }
    
    func setUpCell(contact: CDContact)
    {
        for (n, (headingLabel,descriptionLabel)) in zip(headingLabels, descriptionLabels).enumerated() {
            switch (n+1) {
            case 1:
                headingLabel.text = "Name"
                descriptionLabel.text = contact.name
            case 2:
                headingLabel.text = "Email"
                descriptionLabel.text = contact.email
            case 3:
                headingLabel.text = "Position"
                descriptionLabel.text = contact.position
            default:
                headingLabel.text = nil
                descriptionLabel.text = nil
            }
        }
        
        
        if let imageUrl = contact.photo {
            contactImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "contactLoader"))
        }
    }
    
}
