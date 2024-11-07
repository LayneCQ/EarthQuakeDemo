//
//  EarthQuakeTests.swift
//  EarthQuakeTests
//
//  Created by Layne on 2024/11/7.
//

import XCTest
@testable import EarthQuake

class EarthQuakeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEarthQuakeDecode() throws {
        guard let earthquakeList = loadData(from: "EarthquakeData", decode: EarthQuakeList.self) else {
            XCTFail("Could not decode file EarthquakeData.json")
            return
        }
        
        XCTAssertEqual(earthquakeList.earthQuakes.count, 19)
        let first = earthquakeList.earthQuakes[0]
        XCTAssertEqual(first.id, "us7000lgwp")
        XCTAssertEqual(first.geometry.coordinates, [169.3089, -20.6152, 48])
        
        XCTAssertEqual(first.properties.mag, 7.1)
        XCTAssertEqual(first.properties.place, "118 km S of Isangel, Vanuatu")
        XCTAssertEqual(first.properties.time, 1701953790184)
        XCTAssertEqual(first.properties.updated, 1707608860040)
        XCTAssertNil(first.properties.tz)
        XCTAssertEqual(first.properties.url, "https://earthquake.usgs.gov/earthquakes/eventpage/us7000lgwp")
        XCTAssertEqual(first.properties.detail, "https://earthquake.usgs.gov/fdsnws/event/1/query?eventid=us7000lgwp&format=geojson")
        
        XCTAssertEqual(first.properties.felt, 17)
        XCTAssertEqual(first.properties.cdi, 7.2)
        XCTAssertEqual(first.properties.mmi, 5.906)
        XCTAssertEqual(first.properties.alert, .green)
        XCTAssertEqual(first.properties.status, .reviewed)
        XCTAssertEqual(first.properties.tsunami, 1)
        XCTAssertEqual(first.properties.sig, 788)
        
        XCTAssertEqual(first.properties.net, "us")
        XCTAssertEqual(first.properties.code, "7000lgwp")
        XCTAssertEqual(first.properties.ids, ["at00s5ary7", "us7000lgwp", "pt23341051", "usauto7000lgwp"])
        XCTAssertEqual(first.properties.sources, ["at", "us", "pt", "usauto"])
        XCTAssertEqual(first.properties.types, ["dyfi", "finite-fault", "general-text", "ground-failure", "impact-link", "impact-text", "internal-moment-tensor", "internal-origin", "losspager", "moment-tensor", "origin", "phase-data", "shakemap"])
        XCTAssertEqual(first.properties.nst, 146)
        XCTAssertEqual(first.properties.dmin, 2.637)
        XCTAssertEqual(first.properties.rms, 1.08)
        XCTAssertEqual(first.properties.gap, 20)
        XCTAssertEqual(first.properties.magType, "mww")
        XCTAssertEqual(first.properties.type, .earthquake)
        XCTAssertEqual(first.properties.title, "M 7.1 - 118 km S of Isangel, Vanuatu")
    }
}

extension XCTestCase {
    func loadData<T: Decodable>(from filename: String, decode typeOf: T.Type) -> T? {
        guard let filePath = Bundle.current.path(forResource: filename, ofType: "json") else {
            XCTFail("Could not find file with name \(filename)")
            return nil
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            XCTFail("Could not create data from file with name \(filename)")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)

            return model
        } catch {
            print("Decode error: \(error)")
            return nil
        }
    }
}

extension Bundle {
    
    static var current: Bundle {
        Bundle(for: EarthQuakeTests.self)
    }
}
