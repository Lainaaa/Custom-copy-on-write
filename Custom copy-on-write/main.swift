//
//  Main.swift
//  Custom copy-on-write
//
//  Created by Dmitrij Meidus on 01.04.25.
//

import Foundation

var bmw = Car(model: "BMW", year: 2020, topSpeed: 250)
let bmw2 = bmw

var isCarsEqual = bmw.compare(with: bmw2)
print("bmw and bmw2 are equal: \(isCarsEqual)") // bmw and bmw2 are equal: true

bmw.year = 2021

isCarsEqual = bmw.compare(with: bmw2)
print("bmw and bmw2 are equal: \(isCarsEqual)") // bmw and bmw2 are equal: false
