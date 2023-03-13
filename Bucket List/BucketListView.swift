//
//  ContentView.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/11/23.
//

import SwiftUI

struct BucketListView: View {
    @EnvironmentObject var dataStore: DataStore
    
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack { TextField ("New Bucket Item", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        dataStore.create(newItem)
                        newItem = ""
                        
                    } label: {
                        Image (systemName: "plus.circle.fill")
                    }
                    .disabled (newItem.isEmpty)
                    
                }.padding()
                if !dataStore.bucketList.isEmpty {
                    List {
                        ForEach($dataStore.bucketList) { $item in
                            NavigationLink(value: item) {
                                TextField(item.name, text: $item.name, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                                    .foregroundColor(item.completedDate == .distantPast ? .primary : .red)
                                
                                
                                
                            }
                            .onChange(of: item, perform: { _ in
                                dataStore.saveList()
                            })
                            .listRowSeparator(.hidden)
                        }
                        .onDelete { indexSet in
                            dataStore.delete(indexSet: indexSet)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text("Add your first Bucket List Item")
                    Image("bucketList")
                    Spacer()
                }
            }
                .navigationTitle("Bucket List")
                .navigationDestination(for: BucketItem .self) { item in
                    DetailView(bucketItem: item)
                }
            }
        }
    }


struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
            .environmentObject(DataStore())
    }
}
