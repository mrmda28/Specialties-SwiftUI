//
//  ContentView.swift
//  Specialties
//
//  Created by Dmitriy Maslennikov on 03/08/2021.
//  Copyright © 2021 mrmda28. All rights reserved.
//

import SwiftUI

struct GroupsView: View {
    @State var groups: [Group] = []
    
    let specialty: (Int, String)
    
    var body: some View {
        NavigationView {
            List(groups, id: \.self) { group in
                VStack {
                    Text(group.name)
                }
            } .onAppear() {
                API().getGroups(id: self.specialty.0) { (SpecialtyGroups) in
                    self.groups = SpecialtyGroups.groups }
            }
            .navigationBarTitle(Text(self.specialty.1), displayMode: .inline)
        }
    }
}

struct ContentView: View {
    @State var specialties: [Specialty] = []
    
    var body: some View {
        NavigationView {
            List(specialties, id: \.self) { specialty in
                VStack {
                    NavigationLink(destination: GroupsView(specialty:
                        (specialty.id, specialty.name)))
                    { Text(specialty.name) }
                }
            } .onAppear() {
                API().getSpecialties { (specialties) in
                    self.specialties = specialties }
            }
        .navigationBarTitle("Специальности", displayMode: .inline)
        }
    }
}

struct Specialty: Decodable, Hashable {
    let id: Int
    let name: String
}

struct SpecialtyGroups: Decodable, Hashable {
    let name: String
    let groups: [Group]
}

struct Group: Decodable, Hashable {
    let id: Int
    let name: String
}

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
            
            do {
                let specialties = try! JSONDecoder().decode([Specialty].self, from: data)
                
                DispatchQueue.main.async {
                    completion(specialties)
                }
            } catch {
                print(error)
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let specialty = try! decoder.decode(SpecialtyGroups.self, from: data)
                
                DispatchQueue.main.async {
                    completion(specialty)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
