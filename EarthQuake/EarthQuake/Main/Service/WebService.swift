//
//  WebService.swift
//  EarthQuake
//
//  Created by Layne Zhang on 2024/11/8.
//

import Foundation
import Alamofire
import Combine

class WebService {

    enum Constant {
        static let dataURL: String = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7"
    }

    func loadData() async throws -> EarthQuakeList {
        try await AF.request(Constant.dataURL, interceptor: .retryPolicy)
            .serializingDecodable(EarthQuakeList.self).value
    }
}
