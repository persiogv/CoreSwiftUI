//
//  EnvironmentValues+ImageCache.swift
//  CoreSwiftUI
//
//  Created by Pérsio on 18/04/20.
//

import SwiftUI

public struct ImageCacheKey: EnvironmentKey {
    
    /// Returns a temporary image cahe
    public static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    
    /// Overrides imageCache get and set
    public var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
