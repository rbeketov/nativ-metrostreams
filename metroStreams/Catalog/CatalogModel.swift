//
//  CatalogModel.swift
//  yourProjectName
//
//  Created by Grigoriy on 04.12.2023.
//

import Foundation

final class CatalogModel {
    private let catalogNetworkManager = CatalogService.shared
    
    func loadCatalog(with title: String? = nil,
                     priceUnder: String? = nil,
                     priceUpper: String? = nil,
                     completion: @escaping (Result<[CatalogUIModel], Error>) -> Void) {

        catalogNetworkManager.getCatalogData(with: title,
                                             priceUnder: priceUnder,
                                             priceUpper: priceUpper) { result in
            switch result {
            case .success(let data):
//                print(data)
                let catalogUIModels = data.modelingObjects.map { modelingObject in
                    return CatalogUIModel(
                        modelingId: modelingObject.modelingId,
                        modelingName: modelingObject.modelingName,
                        modelingPrice: "\(modelingObject.modelingPrice)",
                        modelingImageUrl: modelingObject.modelingImageUrl
                    )
                }
                completion(.success(catalogUIModels))
            case .failure(let error):
//                print(error)
                completion(.failure(error))
            }
        }
    }
}
