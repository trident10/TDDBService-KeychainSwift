//
//  DBServiceAble.swift
//  TDDBService
//
//  Created by Yapapp on 14/11/17.
//

import Foundation
import TDResult

public protocol TDDBService: class {
    func apiClient() -> TDDBServiceApi
    func entityType() -> TDDBEntity
    func apiCall(_ data: TDDBData?, methodType: TDDBMethodType, predicate: NSPredicate?, sortDescriptor: [TDDBSortDescriptor]?, queue: DispatchQueue, completion: @escaping TDDBFetchCompletionClosure)
}

private var xoAssociationDBConfigKey: UInt8 = 0
private var xoAssociationDBApiKey: UInt8 = 1
public extension TDDBService{
    
    var configurator: TDDBServiceConfiguratorClient {
        get {
            return (objc_getAssociatedObject(self, &xoAssociationDBConfigKey) as? TDDBServiceConfiguratorClient)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationDBConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var api: TDDBServiceApi {
        get {
            return (objc_getAssociatedObject(self, &xoAssociationDBApiKey) as? TDDBServiceApi)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationDBApiKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func apiCall(_ data: TDDBData?, methodType: TDDBMethodType, predicate: NSPredicate?, sortDescriptor: [TDDBSortDescriptor]?, queue: DispatchQueue = DispatchQueue.global(qos: .background), completion: @escaping TDDBFetchCompletionClosure){
        configurator = TDDBServiceConfiguratorClient()
        configurator.dataSource = self
        let result = configurator.createRequest(data, methodType: methodType, predicate: predicate, sortDescriptor: sortDescriptor, queue: queue)
        switch result {
        case .Success(let dBServiceRequest):
            api = configurator.getApi()
            let queue = dBServiceRequest.queue
            queue.async {[weak self] in
                self?.api.call(dBServiceRequest) { (result) in
                    completion(result)
                }
            }
            
        case .Error(let error):
            completion(TDResult.Error(error))
        }
    }
}

