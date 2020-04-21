//
//  ImageCache.swift
//  CoreSwiftUI
//
//  Created by Pérsio on 18/04/20.
//

import UIKit

public protocol ImageCache {
    
    /// Subscript
    /// - Parameter url: The resource url
    subscript(_ url: String) -> UIImage? { get set }
}

public struct TemporaryImageCache: ImageCache {
    
    // MARK: Properties
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: Image cacue
    
    public subscript(_ key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSString) : cache.setObject(newValue!, forKey: key as NSString) }
    }
}
