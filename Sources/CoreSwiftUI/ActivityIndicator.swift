//
//  ActivityIndicator.swift
//  CoreSwiftUI
//
//  Created by Pérsio on 20/04/20.
//  Copyright © 2020 Persio Vieira. All rights reserved.
//

import SwiftUI

/// Activity indicator representation
public struct ActivityIndicator: UIViewRepresentable {
    
    // MARK: Properties
    
    /// Animating flag
    @Binding public var isAnimating: Bool
    
    /// Activity indicator style
    public let style: UIActivityIndicatorView.Style
    
    // MARK: View representable
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
