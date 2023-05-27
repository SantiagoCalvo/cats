//
//  CatsLoader.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import Foundation

typealias LoadCatsResult = Swift.Result<[RemoteCat], Error>

protocol CatsLoader {
    func load(completion: @escaping (LoadCatsResult) -> Void)
}
