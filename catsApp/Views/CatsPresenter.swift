//
//  CatsPresenter.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import Foundation

protocol CatsViewDelegate {
    func showCats(cats: [Cat])
    func showErrorMessage(errorMessage: String)
}

class CatsPresenter: CatsPresenterProtocol {
    
    let catsLoader: CatsLoader
    var catsViewDelegate: CatsViewDelegate?
    
    init(catsLoader: CatsLoader) {
        self.catsLoader = catsLoader
    }
    
    func getCats() {
        catsLoader.load { [weak self] results in
            guard let self = self else {return}
            switch results {
            case let .success(remoteCats):
                catsViewDelegate?.showCats(cats: self.remoteCatsToLocal(with: remoteCats))
            case .failure:
                catsViewDelegate?.showErrorMessage(errorMessage: "Error getting Cats!")
            }
        }
    }
    
    private func remoteCatsToLocal(with remoteCats: [RemoteCat]) -> [Cat] {
        return remoteCats.map {Cat(breedName: $0.name,
                                   origin: $0.origin,
                                   affectionLevel: $0.affection_level,
                                   intelligence: $0.intelligence,
                                   imageURL: $0.reference_image_id != nil ? URL(string: "https://cdn2.thecatapi.com/images/\($0.reference_image_id!).jpg"): nil)}
    }
}
