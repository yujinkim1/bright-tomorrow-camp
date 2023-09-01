//
//  UIView+Extension.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
