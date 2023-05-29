//
//  ArchivalViewModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 28/05/23.
//

import Foundation

import CoreData
import Combine

class ArchiveViewModel: ObservableObject {
    
    init(_ root: rootModel) {
        self.rm = root
    }
    
    // MARK: - Functionality
    
    public var rm: rootModel
    
    private var cancellableSet: Set<AnyCancellable> = []
    
}
