//
//  ViewModels.swift
//  Specialties
//
//  Created by Dmitriy Maslennikov on 05/08/2021.
//  Copyright © 2021 mrmda28. All rights reserved.
//

import Foundation

class API {
    func getSpecialties(completion: @escaping ([Specialty]) -> ()) {
        guard let url = URL(string: "http://student.ngknn.ru:8001/api/specialties/")
            else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            let specialties = try! JSONDecoder().decode([Specialty].self, from: data)
            
            DispatchQueue.main.async {
                completion(specialties)
            }
        }
        .resume()
    }
    
    func getGroups(id: Int, completion: @escaping (SpecialtyGroups) -> ()) {
        guard let url = URL(string: "http://student.ngknn.ru:8001/api/specialties/\(id)/")
            else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let specialty = try! decoder.decode(SpecialtyGroups.self, from: data)
            
            DispatchQueue.main.async {
                completion(specialty)
            }
        }
        .resume()
    }
}
