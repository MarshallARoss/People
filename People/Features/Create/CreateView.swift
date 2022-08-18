//
//  CreateView.swift
//  People
//
//  Created by Marshall  on 8/18/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismissView
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: .constant(""))
                    TextField("Last Name", text: .constant(""))
                    TextField("Job", text: .constant(""))
                }
                Section {
                    Button("Submit") {
                    }
                }
            }
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    dismiss
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

private extension CreateView {
    var dismiss: some View {
        Button("Dismiss") {
            dismissView()
        }
    }
}


