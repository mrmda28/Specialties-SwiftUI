//
//  ContentView.swift
//  Specialties
//
//  Created by Dmitriy Maslennikov on 03/08/2021.
//  Copyright © 2021 mrmda28. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var specialties: [Specialty] = []
    
    var body: some View {
        NavigationView {
            List(specialties, id: \.self) { specialty in
                VStack {
                    Text(specialty.name)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
