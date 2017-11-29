//
//  DBServiceDataModel.swift
//  TDDBService
//
//  Created by Yapapp on 16/11/17.
//

import Foundation
import TDResult

public enum TDDBMethodType {
    case fetch
    case insert
    case update
    case delete
}

public protocol TDDBEntity {
}

public protocol TDDBData{
}

public struct TDDBResponse{
    public var resultData: TDDBData?
    public var request: TDDBServiceRequest?
    
    public init(request: TDDBServiceRequest?, data: TDDBData?) {
        self.request = request
        self.resultData = data
    }
    
}

public enum TDDBServiceError: Error {
    case noRecordFound
    case invalidEntityType
    case insertionFailed
    case requestGenerationFailed
    case invalidApi
    case apiError
}

public struct TDDBSortDescriptor {
    public let key: String
    public let ascending: Bool
    
    public init(key: String, ascending: Bool = true) {
        self.key = key
        self.ascending = ascending
    }
}

public typealias TDDBFetchCompletionClosure = ((TDResult<TDDBResponse, TDError>) -> Void)


public struct TDDBServiceRequest{
    public var methodType: TDDBMethodType = .fetch
    public var entity: TDDBEntity?
    public var data: TDDBData?
    public var sortDescriptor: [TDDBSortDescriptor]?
    public var predicate: NSPredicate?
    public var queue: DispatchQueue = DispatchQueue.global(qos: .background)
}
