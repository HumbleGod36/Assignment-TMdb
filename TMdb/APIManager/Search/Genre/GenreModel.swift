 

import Foundation

// MARK: - Welcome
struct GenreModel: Codable {
    let genres: [Genre2]
}
 
struct Genre2: Codable {
    let id: Int
    let name: String
}
