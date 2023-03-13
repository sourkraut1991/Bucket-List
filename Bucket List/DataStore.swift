//
//  DataStore.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/13/23.
//

import Foundation


class DataStore: ObservableObject {
    @Published var bucketList: [BucketItem] = []
    // Helps create a json file to safe onto device
    let fileURL = URL.documentsDirectory.appending(path: "bucketList.json")
    
    init() {
        loadItems()
    }
    func loadItems() {
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                bucketList = try JSONDecoder().decode([BucketItem].self, from: data)
                
            } catch {
                // If file is corrupt so you currently the bucketlist is empty so store it and replace damaged file
                saveList()
            }
        }
        
    }
    func update(bucketItem: BucketItem, note: String, completedDate: Date) {
        if let index = bucketList.firstIndex(where: {$0.id == bucketItem.id}) {
            bucketList[index].note = note
            bucketList[index].completedDate = completedDate
            saveList()
        }
    }
    //TODO: go over episode 3 to annotate what each line does.
    func saveList() {
        do {
            let bucketListData = try JSONEncoder().encode(bucketList)
            let bucketListString = String(decoding: bucketListData, as: UTF8.self)
            try bucketListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Could not encode bucket list and save it")
        }
    }
    func create(_ newItem: String) {
        let newBucketItem = BucketItem(name: newItem)
        bucketList.append(newBucketItem)
        saveList()
    }
    func delete(indexSet: IndexSet) {
        bucketList.remove(atOffsets: indexSet)
        saveList()
    }
}


//12:15 stopping point; need to sleep
