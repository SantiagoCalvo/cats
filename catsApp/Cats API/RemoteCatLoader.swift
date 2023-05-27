//
//  RemoteCatLoader.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import Foundation

class RemoteCatsLoader: CatsLoader {
    
    let url: URL
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case serverError
    }
    
    func load(completion: @escaping (LoadCatsResult) -> Void) {
        client.get(from: url) { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .failure:
                completion(.failure(Error.serverError))
            case let .success((data, httpResponse)):
                completion(self.map(data, httpResponse))
            }
        }
    }
    
    private func map(_ data: Data, _ httpResponse: HTTPURLResponse) -> LoadCatsResult {
        if httpResponse.statusCode == 200, let cats = try? JSONDecoder().decode([RemoteCat].self, from: data) {
            return .success(cats)
        }  else {
            return .failure(Error.serverError)
        }
    }
}
