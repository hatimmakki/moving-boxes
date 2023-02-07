//
//  GroupView.swift
//  MovingBoxes
//
//  Created by Hatim Hoho on 7/2/2023.
//

import SwiftUI
import CoreData

struct GroupView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Group.fetchRequest()) var groups: FetchedResults<Group>

    var body: some View {
        NavigationView {
            
            List {
                ForEach(groups, id: \.self) { group in
                    NavigationLink(destination: GroupDetails(group: group)) {
                        Text(group.name ?? "")
                    }
                }
                .onDelete(perform: deleteGroup)
            }
            .navigationBarTitle("Groups")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
        }
    }

    private func deleteGroup(at offsets: IndexSet) {
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

    private var addButton: some View {
        Button(action: {
            let newGroup = Group(context: self.managedObjectContext)
            newGroup.name = "New Group"
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }) {
            Image(systemName: "plus")
        }
    }
}


struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
