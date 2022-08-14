//
//  PeopleView.swift
//  People
//
//  Created by Marshall  on 8/14/22.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0...5, id: \.self) { item in
                            PersonCellView(user: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createPerson
                }
            }
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
        } label: {
            Symbols.plus
                .font(.system(.headline, design: .rounded).bold()
                )
        }

    }
    
}
