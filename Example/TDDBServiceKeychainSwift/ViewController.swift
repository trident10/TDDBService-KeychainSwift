//
//  ViewController.swift
//  TDDBServiceKeychainSwift
//
//  Created by trident10 on 11/28/2017.
//  Copyright (c) 2017 trident10. All rights reserved.
//

import UIKit
import TDDBService
import TDDBServiceKeychainSwift
import TDResult

class ViewController: UIViewController {
    
    var test: Test = Test()
    override func viewDidLoad() {
        super.viewDidLoad()
        let testData :NSString = "Test"
        
        test.call(data: testData, methodType: .insert, predicate: nil, sortDescriptor: nil) { (result) in
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

struct User: TDDBData{
    
}

extension User: TDDBEntity{}


class Test: TDDBService{
    
    func apiClient() -> TDDBServiceApi {
        return TDDBServiceApiKeychain()
    }
    
    func entityType() -> TDDBEntity {
        return "Test"
    }
    
    func call(data:NSString, methodType: TDDBMethodType, predicate: NSPredicate?, sortDescriptor: [TDDBSortDescriptor]?, completion:((TDResult<User, TDError>)-> Void)?){
        apiCall(data, methodType: methodType, predicate: predicate, sortDescriptor: sortDescriptor, queue: DispatchQueue.global()) { (response) in
            print(response)
            
        }
    }
    
}
