//
//  MainViewModel.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import Foundation
import Combine

@MainActor class MainViewModel {

    enum Status {
        case loading
        case success
        case failure
    }
    
    @Published var status: Status?
    var data: EarthQuakeList?
    private let service: WebService = WebService()

    func loadData() {
        status = .loading
        Task {
            do {
                data = try await service.loadData()
                status = .success
            } catch {
                status = .failure
            }
        }
    }
}
