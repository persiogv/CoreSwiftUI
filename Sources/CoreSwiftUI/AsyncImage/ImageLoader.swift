//
//  ImageLoader.swift
//  CoreSwiftUI
//
//  Created by Pérsio on 18/04/20.
//

import Combine
import UIKit

public final class ImageLoader: ObservableObject {
    
    // MARK: Published
    
    @Published var image: UIImage?
    
    // MARK: Properties
    
    private(set) var isLoading = false
    private let url: String
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    // MARK: Initializers
    
    /// Initializer
    /// - Parameters:
    ///   - url: The image url
    ///   - cache: A ImageCache instance
    public init(url: String, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    // MARK: Deinitializer
    
    deinit {
        cancellable?.cancel()
    }
    
    // MARK: Public methods
    
    /// Loads the image from url
    public final func load() {
        guard !isLoading else { return }

        if let image = cache?[url] {
            self.image = image
            return
        }
        
        guard let url = URL(string: url) else {
            return onFinish()
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    /// Cancels image loading
    public final func cancel() {
        cancellable?.cancel()
    }
    
    // MARK: Private methods
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
}
