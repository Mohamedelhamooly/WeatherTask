//
//  JsonHelper.swift
//  WeatherTask
//
//  Created by Mohamed Elhamoly on 12/7/20.
//  Copyright © 2020 mohamed Elhamoly. All rights reserved.
//

import Foundation
class JsonHelper {
    static let shared: JsonHelper = JsonHelper()

     func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
     func parse<T>(jsonData: Data,decodeType: T.Type,completionHandler: (T?,String?) -> Void) where T : Decodable  {
        do {
            let decodedData = try JSONDecoder().decode(decodeType,from: jsonData)
            completionHandler(decodedData,nil)
        } catch {
            completionHandler(nil,"decode error")
        }
    }
}
