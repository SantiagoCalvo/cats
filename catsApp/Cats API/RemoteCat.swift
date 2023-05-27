//
//  RemoteCat.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import Foundation

struct RemoteCat: Decodable {
    let name: String
    let origin: String
    let affection_level: Int
    let intelligence: Int
    let reference_image_id: String?
}
