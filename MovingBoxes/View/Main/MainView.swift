//
//  HomeView.swift
//  MovingBoxes
//
//  Created by Hatim Hoho on 7/2/2023.
//

import SwiftUI
import CoreData

struct MainPage: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Group.getAllGroups()) var groups: FetchedResults<Group>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groups, id: \.id) { group in
                    NavigationLink(destination: GroupDetail(group: group)) {
                        Text(group.name ?? "")
                    }
                }
                .onDelete(perform: deleteGroup)
            }
            .navigationBarTitle("Groups")
            .navigationBarItems(trailing: Button(action: {
                self.addGroup()
            }) {
                Image(systemName: "plus")
            })
        }
    }
    
    func addGroup() {
        let newGroup = Group(context: managedObjectContext)
        newGroup.name = "New Group"
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            let group = groups[index]
            managedObjectContext.delete(group)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
