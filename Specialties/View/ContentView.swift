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
                    NavigationLink(destination: GroupsView(specialty:
                        (specialty.id, specialty.name)))
                    {
                        HStack {
                            Image(String(specialty.id))
                            Text(specialty.name)
                        }
                    }
                }
            } .onAppear() {
                API().getSpecialties { (specialties) in
                    self.specialties = specialties }
            }
        .navigationBarTitle("Специальности")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
