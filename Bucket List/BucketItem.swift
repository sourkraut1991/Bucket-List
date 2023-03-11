//
//  BucketItem.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/11/23.
//

import Foundation

struct BucketItem: Identifiable, Hashable {
    var id = UUID()
    var name:String
    var note = ""
    var completedDate = Date.distantPast
    
    static var samples: [BucketItem] {
        [
            BucketItem.init(name: "Climb Mount Everest"),
            BucketItem.init(name: "Visit Alaska", note: "Go to Anchorage"),
            BucketItem.init(name: "Get Married", note: "Already Married", completedDate: Date())
        ]
    }
}
