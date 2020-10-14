//
//  UIImageView+Ext.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 13/10/20.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
