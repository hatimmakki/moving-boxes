//
//  GroupDetails.swift
//  MovingBoxes
//
//  Created by Hatim Hoho on 7/2/2023.
//

import SwiftUI
import CoreData

struct GroupDetails: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var group: Group
    @FetchRequest(fetchRequest: Box.fetchRequest()) var boxes: FetchedResults<Box>

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Group name", text: $group.name)
                    .padding()

                List {
                    ForEach(boxes, id: \.self) { box in
                        NavigationLink(destination: BoxDetails(box: box)) {
                            Text(box.name ?? "")
                        }
                    }
                    .onDelete(perform: deleteBox)
                }

                Spacer()

                Button(action: {
                    let newBox = Box(context: self.managedObjectContext)
                    newBox.name = "New Box"
                    newBox.group = self.group
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }) {
                    Image(systemName: "plus")
                }
            }
            .navigationBarTitle("Group Details")
            .navigationBarItems(trailing: EditButton())
        }
    }

    private func deleteBox(at offsets: IndexSet) {
        for index in offsets {
            let box = boxes[index]
            managedObjectContext.delete(box)
        }

        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}


struct GroupDetails_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetails()
    }
}
