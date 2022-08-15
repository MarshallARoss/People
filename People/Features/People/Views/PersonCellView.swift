//
//  PersonCell.swift
//  People
//
//  Created by Marshall  on 8/14/22.
//

import SwiftUI

struct PersonCellView: View {
    
    let user: User
    
    var body: some View {
        VStack(spacing: .zero) {
            
            AsyncImage(url: .init(string: user.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                
                PillView(id: user.id)
                
                Text("\(user.firstName) \(user.lastName)" )
                    .foregroundColor(Theme.text)
                    .font(.system(.body, design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Theme.text.opacity((0.1)), radius: 2, x: 0, y: 1)

    }
}

struct PersonCell_Previews: PreviewProvider {
    
    static var previews: some View {
        PersonCellView(user: dev.previewUser)
            .frame(width: 200, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
