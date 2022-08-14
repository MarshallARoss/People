//
//  PillView.swift
//  People
//
//  Created by Marshall  on 8/14/22.
//

import SwiftUI

struct PillView: View {
    
    let id: Int
    
    var body: some View {
        Text("\(id)")
            .font(.system(.caption, design: .rounded).bold())
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.cardAccent, in: Capsule())
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 6)
    }
}
