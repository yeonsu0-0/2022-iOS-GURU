//
//  structs.swift
//  AlamofireBasic
//
//  Created by yeonsu on 2023/01/06.
//


/*  Codable
    자신을 외부 표현으로 변환(Encode)하거나 외부 표현으로 부터 변환(Decode) 할 수 있는 타입으로, Encodable & Decodable로 구성된 유니온 타입(union type) */
import UIKit

struct DummyData:Codable {
    let data:[Personinfo]
    let total:Int
    let page:Int
    let limit:Int
}

struct Personinfo:Codable {
    let id:String
    let title:String
    let firstName:String
    let lastName:String
    let picture:URL?
}

struct PersonDetail:Codable {
    let id:String
    let phone:String
    let lastName:String
    let firstName:String
    let location:Location?
    let email:String
    let gender:String
    let registerDate:String
    let updatedDate:String
    let dateOfBirth:String
    let picture:URL
}

struct Location:Codable {
    let street:String
    let city:String
    let state:String
    let country:String
    let timezone:String
}
