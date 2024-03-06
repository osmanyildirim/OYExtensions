//
//  Decodable+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Decodable {
    /// Init Decodable object with JSON Data
    ///
    ///     let jsonData = """
    ///                         {
    ///                         "id": 1,
    ///                         "name": "Josefina",
    ///                         "surname": "Calvo"
    ///                         }
    ///                     """.oy_data!
    ///
    ///     let decoded = User(from: jsonData)
    public init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let decoded = try? decoder.decode(Self.self, from: data) else { return nil }
        self = decoded
    }

    /// `ClassSample.oy_className`  → output →  "ClassSample"
    public static var oy_className: String {
        String(describing: self)
    }
}
