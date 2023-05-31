//
//  HomeViewModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 29/05/23.
//

import Foundation

import Combine
import CoreData

class HomeViewModel: ObservableObject {
    
    init(_ root: rootModel) {
        self.rm = root
    }
    
    // MARK: - Functionality
    
    public var rm: rootModel
    
    private var cancellableSet: Set<AnyCancellable> = []
    
}
