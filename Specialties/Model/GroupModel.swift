//
//  Models.swift
//  Specialties
//
//  Created by Dmitriy Maslennikov on 05/08/2021.
//  Copyright © 2021 mrmda28. All rights reserved.
//

import Foundation

struct SpecialtyGroups: Decodable, Hashable {
    let name: String
    let groups: [Group]
}

struct Group: Decodable, Hashable {
    let id: Int
    let name: String
}
