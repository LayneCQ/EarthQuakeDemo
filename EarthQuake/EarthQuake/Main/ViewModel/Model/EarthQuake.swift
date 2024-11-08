//
//  EarthQuake.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import Foundation

// ref: https://earthquake.usgs.gov/data/comcat/data-eventterms.php
struct EarthQuake: Decodable {
    
    struct Geometry: Decodable {
        let type: String
        let coordinates: [Float]
    }
    
    struct Properties: Decodable {
        enum Alert: String, Decodable {
            case green, yellow, orange, red
        }
        
        enum Status: String, Decodable {
            case automatic, reviewed, deleted
        }
        
        enum `Type`: String, Decodable {
            case earthquake, quarry
        }
        
        let mag: Float
        let place: String
        let time: String
        let updated: String
        let tz: Int?
        let url: String
        let detail: String
        let felt: Int
        let cdi: Float
        let mmi: Float
        let alert: Alert
        let status: Status
        let tsunami: Int?
        let sig: Int
        let net: String
        let code: String
        let ids: [String]
        let sources: [String]
        let types: [String]
        let nst: Int
        let dmin: Float
        let rms: Float
        let gap: Int
        let magType: String
        let type: `Type`
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case mag, place, time, updated, tz, url, detail, felt, cdi, mmi, alert, status,
                 tsunami, sig, net, code, ids, sources, types, nst, dmin, rms, gap, magType, type, title
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            mag = try container.decode(Float.self, forKey: .mag)
            place = try container.decode(String.self, forKey: .place)

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = .current

            let timeInterval = try container.decode(Double.self, forKey: .time)
            time = formatter.string(from: Date(timeIntervalSince1970: timeInterval / 1000.0))

            let updatedTimeInterval = try container.decode(Double.self, forKey: .updated)
            updated = formatter.string(from: Date(timeIntervalSince1970: updatedTimeInterval / 1000.0))

            tz = try container.decodeIfPresent(Int.self, forKey: .tz)
            url = try container.decode(String.self, forKey: .url)
            detail = try container.decode(String.self, forKey: .detail)
            felt = try container.decode(Int.self, forKey: .felt)
            cdi = try container.decode(Float.self, forKey: .cdi)
            mmi = try container.decode(Float.self, forKey: .mmi)
            alert = try container.decode(Alert.self, forKey: .alert)
            status = try container.decode(Status.self, forKey: .status)
            tsunami = try container.decode(Int.self, forKey: .tsunami)
            sig = try container.decode(Int.self, forKey: .sig)
            net = try container.decode(String.self, forKey: .net)
            code = try container.decode(String.self, forKey: .code)
            
            let idStrings = try container.decode(String.self, forKey: .ids)
            ids = idStrings.components(separatedBy: ",").compactMap {
                if $0.isEmpty {
                    return nil
                } else {
                    return $0
                }
            }
            
            let sourceStrings = try container.decode(String.self, forKey: .sources)
            sources = sourceStrings.components(separatedBy: ",").compactMap {
                if $0.isEmpty {
                    return nil
                } else {
                    return $0
                }
            }
            
            let typesStrings = try container.decode(String.self, forKey: .types)
            types = typesStrings.components(separatedBy: ",").compactMap {
                if $0.isEmpty {
                    return nil
                } else {
                    return $0
                }
            }
            
            nst = try container.decode(Int.self, forKey: .nst)
            dmin = try container.decode(Float.self, forKey: .dmin)
            rms = try container.decode(Float.self, forKey: .rms)
            gap = try container.decode(Int.self, forKey: .gap)
            magType = try container.decode(String.self, forKey: .magType)
            type = try container.decode(`Type`.self, forKey: .type)
            title = try container.decode(String.self, forKey: .title)
        }
        
    }
    
    let id: String
    let geometry: Geometry
    let properties: Properties
}

struct EarthQuakeList: Decodable {
    
    private let earthQuakes: [EarthQuake]

    enum CodingKeys: String, CodingKey {
        case earthQuakes = "features"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        earthQuakes = try container.decode([EarthQuake].self, forKey: .earthQuakes)
    }
}

extension EarthQuakeList {

    var count: Int { earthQuakes.count }

    subscript(index: Int) -> EarthQuake? {
        guard (0..<earthQuakes.count).contains(index) else { return nil }
        return earthQuakes[index]
    }
}
