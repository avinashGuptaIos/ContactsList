//
//  ContactsListViewController.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {
    
    @IBOutlet weak var tableViewx: UITableView!
    
    
    private var contactListViewModel = ContactListViewModel()
    
    private var contacts = [CDContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        //        roomListViewModel.deleteAllObjects(entityName: "CDRoomData") //Not required for Server to DB flow
        setupTableView()
        contactListViewModel.getContactList()
        
        contactListViewModel.contacts.bind { [weak self] (contacts) in
            DispatchQueue.main.async {
                self?.contacts.removeAll()
                self?.contacts.append(contentsOf: contacts)
                self?.tableViewx.reloadData()
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForInternetConnectivity()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForInternetConnectivity()
    }
    
    fileprivate func setupTableView() {
        tableViewx.register(UINib(nibName: ContactTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ContactTableViewCell.reuseIdentifier())
        tableViewx.dataSource = self
        tableViewx.delegate = self
        tableViewx.rowHeight = UITableView.automaticDimension
        tableViewx.estimatedRowHeight = 50
        tableViewx.tableFooterView = UIView()
    }
    
    // MARK: - InternetConnection_Observer
     override func gotInternetConnectivity() {
         super.gotInternetConnectivity()
         contactListViewModel.getContactList()
     }
}


//MARK: UITableViewDataSource, UITableViewDelegate

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier(), for: indexPath) as! ContactTableViewCell
        cell.setUpCell(contact: contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contactDetailsVc = storyboard?.instantiateViewController(identifier: "ContactDetailsViewController") as? ContactDetailsViewController
        {
            contactDetailsVc.contact = contacts[indexPath.row]
            navigationController?.pushViewController(contactDetailsVc, animated: true)
        }
    }
}
