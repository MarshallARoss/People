//
//  ContentView.swift
//  People
//
//  Created by Marshall  on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Welcome to the People App")
            .padding()
            .onAppear {
                print("Users Response")
                dump(
                    try? StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
                )
                print("Single User Response")
                dump(
                    try? StaticJSONMapper.decode(file: "SingleUser", type: UserDetailResponse.self)
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
