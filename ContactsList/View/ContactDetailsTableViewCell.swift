//
//  ContactDetailsTableViewCell.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailsTableViewCell: UITableViewCell {

   
     @IBOutlet weak var headingLabel: UILabel!
     @IBOutlet weak var subHeadingLabel: UILabel!

        
        static func reuseIdentifier() -> String {
          return String(describing: self)
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            headingLabel.text = nil
            subHeadingLabel.text = nil
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        func setUpContactDetailsTableViewCell(contactDetails: CDContact, indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                headingLabel.text = "Name : "
                subHeadingLabel.text = contactDetails.name
            case 1:
                headingLabel.text = "Email : "
                subHeadingLabel.text = contactDetails.email
                
            case 2:
                headingLabel.text = "Position : "
                subHeadingLabel.text = contactDetails.position
            default:
                prepareForReuse()
            }
            selectionStyle = .none
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
    
}
