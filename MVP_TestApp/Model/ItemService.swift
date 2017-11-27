//
//  ItemService.swift
//  MVP_TestApp
//
//  Created by Pranil on 11/24/17.
//  Copyright © 2017 pranil. All rights reserved.
//

import Foundation

class ItemService {
    
    // the service delivers mocked data with a delay
    func getItems(callBack: @escaping(([ItemModel]) -> Void)){
        let items = [
            ItemModel(namaBarang: "Apple MacBook Pro", jumlahBarang: 1, beratBarang: 0.8, hargaBarang: 139949, namaPemesan: "Agus Cahyono", alamatPemesan: "Jl. Taman Bunga Merak II Kav. 67, Malang"),
            ItemModel(namaBarang: "Apple MacBook Air", jumlahBarang: 1, beratBarang: 0.5, hargaBarang: 57540, namaPemesan: "Agus Cahyono", alamatPemesan: "Jl. Taman Bunga Merak II Kav. 67, Malang"),
            ItemModel(namaBarang: "iPhone X", jumlahBarang: 1, beratBarang: 0.3, hargaBarang: 100000, namaPemesan: "Agus Cahyono", alamatPemesan: "Jl. Taman Bunga Merak II Kav. 67, Malang"),
            ]
        
        let delayTime = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(items)
        }
    }

    
}


