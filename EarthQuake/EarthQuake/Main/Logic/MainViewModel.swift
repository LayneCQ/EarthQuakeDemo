//
//  MainViewModel.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import Foundation
import Combine

class MainViewModel {
    
    enum Status {
    case success
    case failure
    }
    
    @Published var status: Status?
    
    func loadData() {
        
    }
}
