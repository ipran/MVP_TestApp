 //
//  ItemPresenter.swift
//  MVP_TestApp
//
//  Created by Pranil on 11/24/17.
//  Copyright © 2017 pranil. All rights reserved.
//

import Foundation

class ItemPresenter {
    
    private let itemService: ItemService
    weak private var itemView: ItemViewModel?
    
    init(itemService: ItemService) {
        self.itemService = itemService
    }
    
    func attachView(view: ItemViewModel) {
        itemView = view
    }
    
    func detachView() {
        itemView = nil
    }
    
    func getItems() {
        
        self.itemView?.startLoading()
        itemService.getItems{ [weak self] items in
            self?.itemView?.finishLoading()
            if items.count == 0 {
                self?.itemView?.setEmptyItems()
            } else {
                let mappedItems = items.map({ data in
                    return ItemViewDataModel(namaBarang: data.namaBarang , hargaBarang: data.hargaBarang)
                })
                self?.itemView?.setItems(items: mappedItems)
            }
        }
    }
}
