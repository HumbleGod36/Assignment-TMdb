//
//  ApiConstants.swift
//  TMdb
//
//  Created by Tony Michael on 29/02/24.
//

import Foundation
 

struct AppStrings {
    
    static let movieListUrl = "upcoming"
    static let authToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMDE5ZThlNDU1YTJiMmFkZmI5ZmE2N2E4YmYxOTI3OCIsInN1YiI6IjY1OWZjOTZhMmUwNjk3MDEyYTc0NTlhOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9Yuvdg55NOBcNRfWApiUKlDAGCQIdyBR7cmnCEB8ASs"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let videoLanguageUrl = "/videos?language=en-US"
    static let genresUrl = "https://api.themoviedb.org/3/genre/movie/list?language=en "
    static let searchBaseUrl = "https://api.themoviedb.org/3/search/movie?query="
    static let searchAdditionUrl = "&include_adult=false&language=en-US&page=1"
    static let errorMessage = "Something Went WRONG!!"
}
