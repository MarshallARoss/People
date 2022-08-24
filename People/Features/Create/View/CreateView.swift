//
//  CreateView.swift
//  People
//
//  Created by Marshall  on 8/18/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismissView
    @StateObject private var vm: CreateViewModel = CreateViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: $vm.person.firstName)
                    TextField("Last Name", text: $vm.person.lastName)
                    TextField("Job", text: $vm.person.job)
                }
                Section {
                    Button("Submit") {
                        vm.create()
                    }
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    dismiss
                }
            }
            .onChange(of: vm.state) { formState in
                if formState == .successful {
                    dismissView()
                }
            }
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
             }
            .alert(isPresented: $vm.hasError, error: vm.error) {}
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


