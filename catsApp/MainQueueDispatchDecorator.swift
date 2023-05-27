//
//  MainQueueDispatchDecorator.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import Foundation

final class MainQueueDispatchDecorator: CatsLoader {
    private let decoratee: CatsLoader

    init(decoratee: CatsLoader) {
        self.decoratee = decoratee
    }

    func load(completion: @escaping (LoadCatsResult) -> Void) {
        decoratee.load { result in
            if Thread.isMainThread {
                completion(result)
            } else {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
