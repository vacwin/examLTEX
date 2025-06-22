//
//  Post.swift
//  examLTEX
//
//  Created by vacwin on 22.06.2025.
//

import Foundation
struct Post: Decodable {
    var id: String?
    var title: String?
    var text: String?
    var image: String?
    var sort: Int?
    var date: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case text = "text"
        case image = "image"
        case sort = "sort"
        case date = "date"
    }
}
