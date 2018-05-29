//
//  FeedsDataSourceTests.swift
//  iOSProgressiveExerciseTests
//
//  Created by Nischal Hada on 5/29/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest

@testable import iOSProgressiveExercise
class FeedsDataSourceTests: XCTestCase {
    var dataSource : FeedsDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = FeedsDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        dataSource.data.value = []  // giving empty data value
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        let responseResults:[ListModel] = getDataValue()
        let newArray = Array(responseResults[0..<2])
        dataSource.data.value = newArray
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        dataSource.data.value = getDataValue()
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(LandscapeTableViewCell.self, forCellReuseIdentifier: "LandscapeTableViewCell")
        let indexPath = IndexPath(row: 0, section: 0)
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? LandscapeTableViewCell else {
            XCTAssert(false, "Expected LandscapeTableViewCell class")
            return
        }
    }
    
    func getDataValue() ->[ListModel]{
        var responseResults = [ListModel]()
        guard let data = FileManager.readJson(forResource: "facts") else {
            XCTAssert(false, "Can't get data from facts.json")
            return responseResults
        }
        let completion : ((Result<FeedsModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                print(converter)
                responseResults = converter.rows
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
        return responseResults
    }
    
}
extension FileManager {
    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: FeedsDataSourceTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
            }
        }
        return nil
    }
}

