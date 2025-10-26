//
//  AddNotesView.swift
//  NotesApp
//
//  Created by Aditya Raj on 26/10/25.
//

import Foundation
import SwiftUI

struct AddNotesView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var notesText: String
    var onAddTap: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Enter your notes here")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    if !notesText.isEmpty {
                        onAddTap()
                        dismiss()
                    } else {
                        print("Please enter some notes")
                    }
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .font(.system(size: 24))
                        .foregroundStyle(.black)
                        .glassEffect()
                }
                
            }
            .padding(.top)
            
            TextEditor(text: $notesText)
                .padding()
                .foregroundStyle(.black)
                .scrollContentBackground(.hidden) // Hide the white system background
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6)) // Use the same color as your sheet or parent view
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
        .padding()
    }
}

#Preview {
    AddNotesView(notesText: .constant(""), onAddTap: { })
}
