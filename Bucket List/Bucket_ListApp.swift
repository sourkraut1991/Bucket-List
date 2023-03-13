//
//  Bucket_ListApp.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/11/23.
//

import SwiftUI

@main
struct Bucket_ListApp: App {
    @State var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environmentObject(dataStore)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
            
        }
    }
}
