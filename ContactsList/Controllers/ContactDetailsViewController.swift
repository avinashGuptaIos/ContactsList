//
//  ContactDetailsViewController.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var tableViewx: UITableView!
    
    var contact: CDContact!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Details"
        setupTableView()
    }
    
    
    fileprivate func setupTableView() {
        tableViewx.register(UINib(nibName: ContactDetailsTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ContactDetailsTableViewCell.reuseIdentifier())
        tableViewx.dataSource = self
        tableViewx.delegate = self
        tableViewx.rowHeight = UITableView.automaticDimension
        tableViewx.estimatedRowHeight = 50
        tableViewx.separatorStyle = .none
        tableViewx.tableFooterView = UIView()
    }
}


//MARK: UITableViewDataSource, UITableViewDelegate

extension ContactDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsTableViewCell.reuseIdentifier(), for: indexPath) as! ContactDetailsTableViewCell
        cell.setUpContactDetailsTableViewCell(contactDetails: contact, indexPath: indexPath)
        return cell
    }
    
}
