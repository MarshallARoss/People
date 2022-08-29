//
//  CreateView.swift
//  People
//
//  Created by Marshall  on 8/18/22.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismissView
    @FocusState private var focusedField: Field?
    @StateObject private var vm: CreateViewModel = CreateViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("First Name", text: $vm.person.firstName)
                        .focused($focusedField, equals: .firstName)
                    TextField("Last Name", text: $vm.person.lastName)
                        .focused($focusedField, equals: .lastName)
                    TextField("Job", text: $vm.person.job)
                        .focused($focusedField, equals: .job)
                } footer: {
                    if case .validation(let error) = vm.error,
                       let errorDesc = error.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    Button("Submit") {
                        focusedField = nil
                        Task {
                            await vm.create()
                        }
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
                    successfulAction()
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

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView {}
    }
}

private extension CreateView {
    var dismiss: some View {
        Button("Dismiss") {
            dismissView()
        }
    }
}


