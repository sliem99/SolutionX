//
//  ValidatableRequest.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 19/02/2025.
//

import Foundation

//MARK:- Request Contract Type
enum RequestContractType {
    
    case headers
    
    case body
    
    case queries

}


//MARK: - Field Key
enum FieldKey: String {

    case products
    
    case isAuthorizationRequired
    
    case JSONContent
    
    case searchQuery
    
}



//MARK: - ValidationProtocol and Extension
protocol ValidatableRequest {
    
    // Provides a request optional and required fields
    //Headers, Body, Queries
    //returned result like
    //        [
    //            RequestContractType.headers: [.JSONContent: true],
    //            RequestContractType.query: [
    //                .products: true,
    //                .searchQuery: false
    //            ]،
    //            RequestContractType.body: [
    //                .products: true,
    //                .searchQuery: flase
    //            ]
    //        ]
    
    func getRequestContract() -> [RequestContractType: [FieldKey: Bool]]
    
    
    //Start point of validation
    func validateRequestContract() -> [FieldKey: [SolutionXException]]
    
    //Get request contract values
    func getRequestHeaders() -> [FieldKey: String] //[ fieldKey.jsoncontent: "sfddsf"]
    
    func getRequestQueries() -> [FieldKey: String]
    
    func getRequestBody() -> [FieldKey: Any]
    
    // to remove duplicate validation for optional keys for
    func validateFieldData(_ field: FieldKey, value: Any) -> [SolutionXException]?
}

extension ValidatableRequest {
    //Steps: -
    //validate required, throw error map if found
    //validate optional keys
        
    func validateRequestContract() -> [FieldKey: [SolutionXException]] {
        let contractMap = getRequestContract() // defines required and optional fields
        let contractValuesMap = buildContractValuesMap()
        
        var errorMap = validateRequiredKeys(contract: contractMap, values: contractValuesMap)
        
        let optionalErrors = validateOptionalKeys(contract: contractMap, values: contractValuesMap)
        errorMap.merge(optionalErrors) { _, new in new }
        
        return errorMap
    }
    
    private func buildContractValuesMap() -> [FieldKey: Any] {
        let headers = getRequestHeaders()
        let queries = getRequestQueries()
        let body = getRequestBody()
    
        var contractMap: [FieldKey: Any] = [:]
        contractMap.merge(headers) { (_, new) in new }
        contractMap.merge(queries) { (_, new) in new }
        contractMap.merge(body) { (_, new) in new }
        
        return contractMap
    }
    
    private func validateRequiredKeys(
        contract: [RequestContractType: [FieldKey: Bool]],
        values: [FieldKey: Any]
    ) -> [FieldKey: [SolutionXException]] {
        
        var errorMap: [FieldKey: [SolutionXException]] = [:]
        
        for type in contract.values {
            
            type.forEach { (field, isRequired) in
                    
                if isRequired {

                    let fieldValue = values[field]
                    
                    if !values.keys.contains(field) {
                        errorMap[field, default: []].append(
                            SolutionXException.requestValidation(.missingField)
                        )
                    }

                    if fieldValue == nil {
                        errorMap[field, default: []].append(
                            SolutionXException.requestValidation(.requiredField)
                        )
                    }
                    
                    //Input validation
                    if let fieldValue, let fieldErrors = validateFieldData(field, value: fieldValue) {
                        errorMap[field, default: []].append(contentsOf: fieldErrors)
                    }
                }
            }
        }
        
        return errorMap
    }
    
    
    private func validateOptionalKeys(
        contract: [RequestContractType: [FieldKey: Bool]],
        values: [FieldKey: Any]
    ) -> [FieldKey: [SolutionXException]] {
        
        var errorMap: [FieldKey: [SolutionXException]] = [:]
        
        for type in contract.values {
            
            type.forEach { (field, required) in
                
                guard !required else { return }
                
                if let fieldValue = values[field] { // is not empty
                    guard let errors = validateFieldData(field, value: fieldValue) else { return }
                    errorMap[field, default: []].append(contentsOf: errors)
                }
            }
        }
        
        return errorMap
    }
}


//MARK: - Request

//struct AddProductRequest: ValidatableRequest {
//    func getRequestContract() -> [RequestContractType : [FieldKey : Bool]] {
//        
//        [
//            .body : [.products: false],
//            
//                .headers: [.JSONContent: true],
//            
//                .queries: [
//                    .products: true,
//                    .searchQuery: true
//                ]
//        ]
//    }
//    
//    func getRequestHeaders() -> [FieldKey : String] {
//        
//    }
//    
//    func getRequestQueries() -> [FieldKey : String] {
//        return [:]
//    }
//    
//    func getRequestBody() -> [FieldKey : Any] {
//        return [:]
//    }
//    
//    
//    func validateFieldData(_ field: FieldKey, value: Any) -> [SolutionXException]? {
//        
//        let errors: [SolutionXException] = []
//        
////        switch field {
////        case .products:
////            let error = Validator.validateProduct(value)
////            errors.append(contentsOf: error)
////        case .searchQuery:
////             let error = Validator.validateSearch(value)
////            errors.append(contentsOf: error)
////        default:
////            break
////        }
//        return errors
//    }
//    
//    
//}
