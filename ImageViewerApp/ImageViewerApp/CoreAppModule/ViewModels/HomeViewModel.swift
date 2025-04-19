//
//  HomeViewModel.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var photos: [UnsplashPhoto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasError = false
    @Published var currentPage = 1
    @Published var searchQuery = ""
    @Published var isSearching = false
    
    private let apiService: UnsplashAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: UnsplashAPIServiceProtocol) {
        self.apiService = apiService
        //Debounce search query changes
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                if !query.isEmpty {
                    self.resetForNewSearch()
                    Task {
                        await self.searchPhotos(query: query)
                    }
                } else if self.isSearching {
                    self.isSearching = false
                    self.resetForNewSearch()
                    Task {
                        await self.loadPhotos()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func loadPhotos() async {
        guard !isLoading else { return }
        isLoading = true
        hasError = false
        errorMessage = nil
        do {
            let newPhotos = try await apiService.fetchPhotos(page: currentPage)
            let validPhotos = newPhotos.filter { $0.id != nil }
            self.photos.append(contentsOf: validPhotos)
            self.currentPage += 1
        } catch let error as APIError {
            self.hasError = true
            self.errorMessage = error.description
        } catch {
            self.hasError = true
            self.errorMessage = "An unexpected error occurred"
        }
        self.isLoading = false
    }
    
    func searchPhotos(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        hasError = false
        errorMessage = nil
        isSearching = true
        do {
            let response = try await apiService.searchPhotos(query: query, page: currentPage)
            if let results = response.results { //Filter out any photos with nil IDs
                let validPhotos = results.filter { $0.id != nil }
                self.photos.append(contentsOf: validPhotos)
                self.currentPage += 1
            }
        } catch let error as APIError {
            self.hasError = true
            self.errorMessage = error.description
        } catch {
            self.hasError = true
            self.errorMessage = "An unexpected error occurred"
        }
        self.isLoading = false
    }
    
    func loadMoreIfNeeded(currentItem: UnsplashPhoto) {
        guard let currentId = currentItem.id else { return }
        let thresholdIndex = max(0, photos.count - 1)
        if photos.count > 0 && photos.firstIndex(where: { $0.id == currentId }) == thresholdIndex {
            Task {
                if isSearching && !searchQuery.isEmpty {
                    await searchPhotos(query: searchQuery)
                } else {
                    await loadPhotos()
                }
            }
        }
    }
    
    private func resetForNewSearch() {
        photos = []
        currentPage = 1
    }
    
    func retryLastOperation() {
        Task {
            if isSearching && !searchQuery.isEmpty {
                await searchPhotos(query: searchQuery)
            } else {
                await loadPhotos()
            }
        }
    }
}
