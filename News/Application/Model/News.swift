//
//  News.swift
//  News
//
//  Created by Евгений Сергеевич on 14.03.2021.
//

import Foundation

// MARK: - News
struct News: Decodable {
    let status, copyright, section: String?
    let last_updated: String?
    let num_results: Int?
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let section, subsection, title, abstract: String?
    let url: String?
    let uri, byline: String?
    let updatedDate, createdDate, publishedDate: Date?
    let materialTypeFacet, kicker: String?
    let shortURL: String?
    let multimedia: [Multimedia]
}
struct Multimedia: Decodable {
    let url: String?
    let height, width: Int?
    let caption, copyright: String?
}
