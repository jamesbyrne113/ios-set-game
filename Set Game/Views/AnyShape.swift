//
//  AnyShape.swift
//  Set Game
//
//  Created by James Byrne on 07/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

struct AnyShape: Shape {
    private let path: (CGRect) -> Path
    
    init<S: Shape>(_ wrapped: S) {
        path = {
            rect in
            wrapped.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        path(rect)
    }
}
