//
//  SquareSegmentControl.swift
//  GetUpside-Challenge-App
//
//  Created by Roman Vovk on 14.11.2021.
//

import UIKit

final class SquareSegmentControl: UISegmentedControl {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
    }
}
