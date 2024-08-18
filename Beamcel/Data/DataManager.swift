//
//  DataManager.swift
//  Beamcel
//
//  Created by Marcel Kersten on 15.08.24.
//

import Foundation

protocol DataManager {
    func getRequestCollection(id: String) -> BeamcelProject
    func createRequestCollectionStory(name: String)
    func createHttpRequest()
}
