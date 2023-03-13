//
//  DetailView.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/11/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataStore: DataStore
    let bucketItem: BucketItem
    @State private var note = ""
    @State private var completedDate = Date.distantPast
    @Environment(\.dismiss) var dismiss
   
    var body: some View {
        Form {
            TextField("bucket note", text: $note, axis: .vertical)
            if completedDate != Date.distantPast {
                DatePicker("Completed On", selection: $completedDate, displayedComponents: .date)
            }
            Button(completedDate == Date.distantPast ? "Add Date" : "Clear Date") {
                if completedDate == Date.distantPast {
                    completedDate = Date()
                } else {
                    completedDate = Date.distantPast
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            note = bucketItem.note
            completedDate = bucketItem.completedDate
            
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    dataStore.update(bucketItem: bucketItem, note: note, completedDate: completedDate)
                    
                        dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle(bucketItem.name)
    }
}


struct DetailView_Previews: PreviewProvider {
    static let bucketItem = BucketItem.samples[2]
    static let bucketList: Binding<[BucketItem]> = .constant(BucketItem.samples)
    static var previews: some View {
        NavigationStack {
            DetailView(bucketItem: bucketItem).environmentObject(DataStore())
        }
    }
}
