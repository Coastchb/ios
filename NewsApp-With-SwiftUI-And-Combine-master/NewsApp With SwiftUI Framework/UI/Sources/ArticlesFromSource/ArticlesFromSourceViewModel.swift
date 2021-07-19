//
//  ArticlesFromSourceViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class ArticlesFromSourceViewModel: ObservableObject {
    private let apiProvider: APIProviderProtocol = APIProvider.shared
    
    private var cancellable: Cancellable?
    
    @Published private(set) var articles: Articles = []
    
    deinit {
        cancellable?.cancel()
    }
    
    func getArticles(from source: String) {
        cancellable = apiProvider.getData(from: ArticlesEndpoints.getArticlesFromSource(source))
            .decode(type: ArticlesResponse.self, decoder: Container.jsonDecoder)
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (articles) in
                self?.articles = articles
            })
    }
}
