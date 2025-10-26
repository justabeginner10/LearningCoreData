//
//  HomeView.swift
//  NotesApp
//
//  Created by Aditya Raj on 26/10/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Notes.content, ascending: true)
    ]) var notes: FetchedResults<Notes>
    
    @State private var enteredNotes: String = ""
    @State private var presentAddNotesView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes, id: \.self) { note in
                    VStack(alignment: .center) {
                        Text(note.content ?? "")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                if !notes.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                ToolbarItem {
                    Button {
                        presentAddNotesView = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $presentAddNotesView) {
                Text("Add Here")
                    .presentationDetents([.height(300)])
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addNotes() {
        withAnimation {
            let newItem = Notes(context: viewContext)
            newItem.content = enteredNotes
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.previewNotes.container.viewContext)
}
