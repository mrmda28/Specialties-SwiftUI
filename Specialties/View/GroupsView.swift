//
//  GroupsView.swift
//  Specialties
//
//  Created by Dmitriy Maslennikov on 05/08/2021.
//  Copyright © 2021 mrmda28. All rights reserved.
//

import SwiftUI

struct GroupsView: View {
    @State var groups: [Group] = []
    
    let specialty: (Int, String)
    
    var body: some View {
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
