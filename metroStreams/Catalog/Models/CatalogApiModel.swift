//
//  CatalogApiModel.swift
//  yourProjectName
//
//  Created by Grigoriy on 04.12.2023.
//

//import Foundation
//
//struct CatalogApiModel: Codable {
//    let modeling_objects: Modeling_objects
//}
//
//struct Modeling_objects: Codable {
//    let modeling_id: Int
//    let modeling_name: String
//    let modeling_price: Double
//    let modeling_image_url: String
//}

import Foundation

struct ModelingObject: Codable {
    let modelingId: Int
    let modelingName: String
    let modelingPrice: String
    let modelingImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case modelingId = "modeling_id"
        case modelingName = "modeling_name"
        case modelingPrice = "modeling_price"
        case modelingImageUrl = "modeling_image_url"
    }
}

struct CatalogApiModel: Codable {
//    let draftId: Int?
    let modelingObjects: [ModelingObject]
    
    enum CodingKeys: String, CodingKey {
        case modelingObjects = "modeling_objects"
    }
}

