//
//  DetailInformatioModel.swift
//  metroStreams
//
//  Created by Роман Бекетов on 14.12.2023.
//

import Foundation

final class DetailInformatioModel {
    private let catalogNetworkManager = CatalogService.shared
    
    func loadDetailInformation(with id: Int, completion: @escaping (Result<DetailInformationApiModel, Error>) -> Void) {
        catalogNetworkManager.getCatalogDelailData(with: id) { result in
            completion(result)
        }
    }
}
