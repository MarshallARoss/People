//
//  PeopleView.swift
//  People
//
//  Created by Marshall  on 8/14/22.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject var vm: PeopleViewModel
    
    init() {
        #if DEBUG
        if UITestingHelper.isUITesting {
            let mock: NetworkingManagerImpl = UITestingHelper.isPeopleNetworkingSuccessful ? NetworkingManagerUserResponseSuccessMock() : NetworkingManagerUserResponseFailureMock()
            _vm = StateObject(wrappedValue: PeopleViewModel(networkingManager: mock))
        } else {
        _vm = StateObject(wrappedValue: PeopleViewModel())
        }
        #else
        _vm = StateObject(wrappedValue: PeopleViewModel())
        #endif
    }
    
    @State private var showCreateUser = false
    @State private var showSuccess = false
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userID: user.id)
                                } label: {
                                    PersonCellView(user: user)
                                        .accessibilityIdentifier("item_\(user.id)")
                                        .task {
                                            if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                                await vm.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                        .accessibilityIdentifier("peopleGrid")
                    }
                    .overlay(alignment: .bottom) {
                        if vm.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .sheet(isPresented: $showCreateUser, content: {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.showSuccess.toggle()
                    }
                }
            })
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createPerson
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    refreshButton
                }
            }
            //            .onAppear {
            //                Task {
            //                    await vm.fetchUsers()
            //                }
            //            }
            .task {
                if !hasAppeared {
                    await vm.fetchUsers()
                    hasAppeared = true
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchUsers()
                    }
                }
            }
            .overlay {
                if showSuccess == true {
                    CheckmarkView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.showSuccess.toggle()
                                }
                            }
                        }
                }
            }
            
            //            .onAppear {
            //                do {
            //                    let res = try StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
            //                    users = res.data
            //
            //                } catch {
            //                    //TODO: - Handle Error
            //                    print(error)
            //                }
            //            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}


private extension PeopleView {
    
    var background: some View {
        Theme
            .background.ignoresSafeArea()
    }
    
    var createPerson: some View {
        Button {
            //NEW PERSON
            showCreateUser.toggle()
        } label: {
            Symbols.plus
                .font(.system(.headline, design: .rounded).bold()
                )
        }
        .disabled(vm.isLoading)
    }
    
    var refreshButton: some View {
        Button {
            Task {
                await vm.fetchUsers()
            }
        } label: {
            Symbols.refresh
        }
        .disabled(vm.isLoading)
    }
}


