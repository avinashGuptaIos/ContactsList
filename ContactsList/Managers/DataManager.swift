//
//  DataManager.swift
//  ContactsList
//
//  Created hasher mac on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation
import CoreData

let DataManagerSharedInstance = DataManager.shared

class DataManager {
    private init(){ }
    static let shared = DataManager()

    private let dataBaseQueue = DispatchQueue(label: "dataBaseQueue", attributes: .concurrent)

    //MARK: ContactList CRUD Operations
    func saveContactListToDb(contactList: [ContactObject], callback: @escaping DataExists) {
        dataBaseQueue.async { [weak self] in
            if contactList.count > 0{
                self?.deleteAllObjects(entityName: "CDContact")
            }
            for contact in contactList{
                let contactx = CDContact(context: AppDelegate_ViewContext)
                contactx.name = contact.name
                contactx.email = contact.email
                contactx.position = contact.position
                contactx.photo = contact.photo
            }
            AppDelegate.shared().saveContext()
            callback(contactList.count > 0)
        }
    }

    func loadSavedContactList(callback:@escaping (_ contactList: [CDContact]?) -> Void){
        dataBaseQueue.async(flags: .barrier) {
            let fetchRequest =  NSFetchRequest<CDContact>(entityName: "CDContact")
            let contacts = try? AppDelegate_ViewContext.fetch(fetchRequest)
            callback(contacts)
        }
    }

    //MARK: Delete Any Entity using Batch Request

    func deleteAllObjects(entityName: String) {
        dataBaseQueue.sync {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try AppDelegate_ViewContext.execute(batchDeleteRequest)
                AppDelegate.shared().saveContext()
            } catch let error {
                print("Error happened while deleting the records \(error.localizedDescription)")
            }
        }
    }

}
