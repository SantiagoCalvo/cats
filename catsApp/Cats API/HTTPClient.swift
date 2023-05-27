//
//  HTTPClient.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import Foundation

import Foundation

public typealias HTTPClientResult = Swift.Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
