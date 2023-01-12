//
//  ViewController.swift
//  FirestoreBasic
//
//  Created by yeonsu on 2023/01/12.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    let db = Firestore.firestore()  // 파이어베이스 접속 권한

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* setData */
        // 데이터 생성
        var ref: DocumentReference? = nil
        ref = db.collection("cities").addDocument(data: [
            "name": "Tokyo",
            "country": "Japan"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        // 데이터 생성
        db.collection("cities").document("LA").setData([
            "name": "Los Angeles",
            "state": "CA",
            "country": "USA"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // 데이터 생성
        let washingtonRef = db.collection("cities").document("DC")
        washingtonRef.setData([
            "name": "Los Angeles",
            "state": "CA",
            "country": "USA"
        ])

        // 업데이트
        // Set the "capital" field of the city 'DC'
        washingtonRef.updateData([
            "capital": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
        //
        // 중첩된 필드 업데이트
        // Create an initial document to update.
        let frankDocRef = db.collection("users").document("frank")
        frankDocRef.setData([
            "name": "Frank",
            "favorites": [ "food": "Pizza", "color": "Blue", "subject": "recess" ],
            "age": 12
            ])

        // To update age and favorite color:
        db.collection("users").document("frank").updateData([
            "age": 13,
            "favorites.color": "Red"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        //
        
        
        // 데이터 읽기
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }

    }


}

