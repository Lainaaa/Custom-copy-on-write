//
//  Car.swift
//  Custom copy-on-write
//
//  Created by Dmitrij Meidus on 01.04.25.
//

struct Car {
    private var storage: CarStorage
    
    init(model: String, year: Int, topSpeed: Int) {
        self.storage = CarStorage(model: model, year: year, topSpeed: topSpeed)
    }
}

private extension Car{
    final class CarStorage{
        var model: String
        var year: Int
        var topSpeed: Int
        
        init(model: String, year: Int, topSpeed: Int) {
            self.model = model
            self.year = year
            self.topSpeed = topSpeed
        }
        
        func copyWith(model: String? = .none, year: Int? = .none, topSpeed: Int? = .none) -> CarStorage{
            CarStorage(model: model ?? self.model, year: year ?? self.year, topSpeed: topSpeed ?? self.topSpeed)
        }
    } 
}

extension Car{
    private var storageForWrtiting: CarStorage{
        mutating get{
            if !isKnownUniquelyReferenced(&storage){
                self.storage = storage.copyWith()
            }
            return storage
        }
    }
    
    var model: String {
        get {
            storage.model
        }
        set(newModel){
            storageForWrtiting.model = newModel
        }
    }
    var year: Int {
        get {
            storage.year
        }
        set(newYear){
            storageForWrtiting.year = newYear
        }
    }
    var topSpeed: Int {
        get {
            storage.topSpeed
        }
        set(newTopSpeed){
            storageForWrtiting.topSpeed = newTopSpeed
        }
    }
}

extension Car{
    func compare(with car: Car) -> Bool {
        self.storage === car.storage
    }
}
