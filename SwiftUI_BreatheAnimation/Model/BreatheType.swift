//
//  BreatheType.swift
//  SwiftUI_BreatheAnimation
//
//  Created by パク on 2023/03/15.
//

import SwiftUI

struct BreatheType: Identifiable, Hashable {
    var id = UUID().uuidString
    var title: String
    var color: Color
}

let sampleTypes: [BreatheType] = [
    .init(title: "Anger", color: .mint),
    .init(title: "Irritation", color: .brown),
    .init(title: "Sadness", color: Color("Purple"))
]
