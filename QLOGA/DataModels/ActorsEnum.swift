//
//  ActorsEnum.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/13/22.
//

import Foundation

enum ActorsEnum: String, CaseIterable, Identifiable {
    case QLOGA
    case CUSTOMER
    case  PROVIDER
    case  RESOURCE
    case  JOB_APPLICANT
    var id: String { self.rawValue }
}
