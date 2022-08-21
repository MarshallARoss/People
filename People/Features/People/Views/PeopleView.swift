//
//  PeopleView.swift
//  People
//
//  Created by Marshall  on 8/14/22.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject var vm: PeopleViewModel = PeopleViewModel()
    
    @State private var showCreateUser = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(vm.users, id: \.id) { user in
                            NavigationLink {
                                DetailView(userID: user.id)
                            } label: {
                                PersonCellView(user: user)
                            }

                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showCreateUser, content: {
                CreateView()
            })
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createPerson
                }
            }
            .onAppear(perform: {
                vm.fetchUsers()
            })
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

    }
    
}
