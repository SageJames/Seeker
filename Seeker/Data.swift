//
//  Data.swift
//  Seeker
//
//  Created by user178654 on 12/6/20.
//

import Foundation

let newsData:[News] = load("news.json")

func load<T:Decodable>(_ filename:String, as type:T.Type = T.self)-> T{
    let data:Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Could not find \(filename) in main bundle.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) from main: \n\(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
