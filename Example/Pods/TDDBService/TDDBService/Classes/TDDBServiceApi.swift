//
//  DBServiceApi.swift
//  TDDBService
//
//  Created by Yapapp on 16/11/17.
//

import Foundation
import TDResult

public protocol TDDBServiceApi{
    var request: TDDBServiceRequest? {get set}
    func call(_ request: TDDBServiceRequest, completionHandler: @escaping TDDBFetchCompletionClosure)
}

public class TDDBServiceApiDefault: TDDBServiceApi{
    public var request: TDDBServiceRequest?
    
    public func call(_ request: TDDBServiceRequest, completionHandler: @escaping TDDBFetchCompletionClosure) {
        completionHandler(TDResult.Error(TDError.init(TDDBServiceError.invalidApi, description: "Default Api doesnot store any data. Either create your own api or refer other dbservice conformer APIs")))
    }
    
    public init(){}
}

