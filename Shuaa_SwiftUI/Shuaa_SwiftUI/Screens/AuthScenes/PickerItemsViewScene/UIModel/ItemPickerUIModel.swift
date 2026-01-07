//
//  ItemPickerUIModel.swift
//  Shuaa


import Foundation
protocol ItemPickerModelType{
    var key:String{get set}
    var id:String{get set}
    var name:String{get set}
    var subName:String{get set}
}
struct ItemPickerUIModel:ItemPickerModelType{
    var key:String = ""
    var name:String
    var subName:String = ""
    var id:String = UUID().uuidString
}
