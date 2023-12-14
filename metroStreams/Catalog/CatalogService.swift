//
//  CatalogService.swift
//  yourProjectName
//
//  Created by Grigoriy on 04.12.2023.
//

import Foundation
// enum для пробрасывания ошибок
enum NetworkError: Error {
    case urlError
    case emptyData
}

final class CatalogService {
    private init() {} // singleton
    static let shared = CatalogService() // singleton
    
    //(completion: @escaping (Result<CatalogService, Error>) -> Void) - замыкание
    // (Result<CatalogService, Error>) - принимает 1 из двух состояний CatalogService или Error
    func getCatalogData(
        with name: String?,
        priceUnder: String? = nil,
        priceUpper: String? = nil,
        completion: @escaping (Result<CatalogApiModel, Error>) -> Void) {
            var urlString = "http://localhost/api/modelings/"

            if let name = name {
                urlString += "?name=\(name)"
            }

            if let price_under = priceUnder {
                urlString += "&price_under=\(price_under)"
            }
            
            if let price_upper = priceUpper {
                urlString += "&price_upper=\(price_upper)"
            }
            
            guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: urlStringEncoded) else {
                completion(.failure(NetworkError.urlError))
                return
            }
            
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in  // completionHandler – замыкание для обработки  данных  в другом слое (в данном случае  view controller)
                //if let, guard let - разные виды развертывания опционала
                if let error = error {
                    print("error with \(error.localizedDescription)") // внутри error != nil
                    completion(.failure(error))
                }
                // снаружи error == nil
                
                guard let data = data else {
                    completion(.failure(NetworkError.emptyData)) // внутри data == nil
                    return
                }
                // снаружи data != nil
                do {
                    let catalogData = try JSONDecoder().decode(CatalogApiModel.self, from: data) //декодируем json в созданную струткру с данными
                    completion(.success(catalogData))
                } catch let error {
                    completion(.failure(error))
                }
            }).resume() // запускаем задачу
        }
    
    func getCatalogDelailData(with id: Int, completion: @escaping (Result<DetailInformationApiModel, Error>) -> Void) {
        var urlString = "http://localhost/api/modelings/\(id)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                print("error")
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            do {
                let catalogData = try JSONDecoder().decode(DetailInformationApiModel.self, from: data)
                completion(.success(catalogData))
            } catch let error {
                completion(.failure(error))
            }
        }).resume() // запускаем задачу
    }
}
