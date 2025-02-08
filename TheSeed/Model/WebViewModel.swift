//
//  WebViewModel.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 10/12/2022.
//

import Foundation
class WebViewModel: ObservableObject {
    @Published var article: Article
    @Published var didFinishLoading: Bool = false
    @Published var isLoadingView: Bool = true
    @Published var loaderView: LoadingView = LoadingView()

    init (article: Article) {
        self.article = article
    }
} 
