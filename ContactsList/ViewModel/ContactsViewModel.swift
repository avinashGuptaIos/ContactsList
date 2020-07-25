
//
//  ContactListViewModel.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation
import CoreData


class ContactListViewModel {
    
    var contacts: Box<[CDContact]> = Box([])
    
    func getContactList() {
        START_LOADING_VIEW()
        if Utils.isInternetAvailable() {
            fetchContactListFromServer { [weak self] (dataExists) in
                STOP_LOADING_VIEW()
                if dataExists
                {
                    self?.loadSavedContactList { [weak self] (contactListx) in
                        if let contactList = contactListx , contactList.count > 0 {
                            self?.contacts.value = contactList
                        }
                    }
                }
            }
        }
        else
        {
            loadSavedContactList { [weak self] (contactListx) in
                if let contactList = contactListx , contactList.count > 0 {
                    STOP_LOADING_VIEW()
                    self?.contacts.value = contactList
                }
            }
        }
    }
    
}


// MARK: - Private Methods
private extension ContactListViewModel {
    func fetchContactListFromServer(callback: @escaping DataExists) {
        
        ServiceManagerSharedInstance.methodType(requestType: GET_REQUEST, url: "", params: nil, paramsData: nil, completion: { [weak self] (_ response,_ responseData, _ statusCode) in
            if let contactListData = responseData, statusCode == 200{
                let contactList = try? JSONDecoder().decode([ContactObject].self, from: contactListData)
                self?.saveContactListToDb(contactList: contactList ?? [], callback: callback)
            }
        }) {  (_ failure, _ statusCode) in
            print("Error happened \(failure.debugDescription)")
            callback(false)
        }
    }
    
    func saveContactListToDb(contactList: [ContactObject], callback: @escaping DataExists) {
        DataManagerSharedInstance.saveContactListToDb(contactList: contactList, callback: callback)
    }
    
    func loadSavedContactList(callback:@escaping (_ contactList: [CDContact]?) -> Void){
        DataManagerSharedInstance.loadSavedContactList(callback: callback)
    }
    
}
