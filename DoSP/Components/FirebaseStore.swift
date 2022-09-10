//
//  FirebaseStore.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/04.
//


import FirebaseFirestore
import Foundation

class FirebaseStore {
    
    static let shared = FirebaseStore()
    
    var db: Firestore!
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        // [END setup]
        db = Firestore.firestore()
    }
    
    func addData(data: [String: Any]) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
   
}
