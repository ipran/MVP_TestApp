//
//  ItemViewModel.swift
//  MVP_TestApp
//
//  Created by Pranil on 11/24/17.
//  Copyright © 2017 pranil. All rights reserved.
//

import Foundation

protocol ItemViewModel : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setItems(items: [ItemViewDataModel])
    func setEmptyItems()

}
