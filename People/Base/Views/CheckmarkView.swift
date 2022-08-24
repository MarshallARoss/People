//
//  CheckmarkView.swift
//  People
//
//  Created by Marshall  on 8/24/22.
//

import SwiftUI

struct CheckmarkView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CheckmarkView()
            CheckmarkView()
                .preferredColorScheme(.dark)

        }
        .padding()
        .background(.orange)
        .previewLayout(.sizeThatFits)
    }
}
