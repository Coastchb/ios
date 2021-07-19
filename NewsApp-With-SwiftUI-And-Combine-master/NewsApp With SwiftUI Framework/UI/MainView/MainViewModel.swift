//
//  MainViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    private let apiProvider: APIProviderProtocol = APIProvider.shared
    
    private var cancellable: Cancellable?
    
    @Published private(set) var topHeadlines: Articles = []
    
    deinit {
        cancellable?.cancel()
    }
    
    func clearTopHeadlines() {
        self.topHeadlines = []
    }
    
    func getTopHeadlines() {
        cancellable = apiProvider.getData(from: ArticlesEndpoints.getTopHeadlines)
            .decode(type: ArticlesResponse.self, decoder: Container.jsonDecoder)
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (articles) in
                self?.topHeadlines = articles
            })
    }
}
