//
//  PickerItemsDelegate.swift
//  Shuaa

import Foundation
protocol PickerItemsDelegate{
    func onSelect(tag:Int,model:ItemPickerModelType)
    func onSelectMulti(tag:Int,model:[ItemPickerModelType])
}
