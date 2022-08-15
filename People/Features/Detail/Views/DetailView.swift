//
//  DetailView.swift
//  People
//
//  Created by Marshall  on 8/15/22.
//

import SwiftUI

struct DetailView: View {
    
    let user: User
    
    var body: some View {
        ZStack {
            background
            ScrollView {
                
                VStack(alignment: .leading, spacing: 18){
                    
                    Group {
                    userInfo
                    link
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 19)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

                }
                .padding()
            }
        }
    }
}

private extension DetailView {
    
    var userInfo: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            PillView(id: 0)
            
            Group {
                firstName
                Divider()
                lastName
                Divider()
                email
            }
            .foregroundColor(Theme.text)
        }
    }
    
    var link: some View {
        Link(destination: .init(string: "https://reqres.in/#support-heading")!) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Support Reqres")
                    .foregroundColor(Theme.text)
                    .font(.system(.body, design: .rounded).weight(.semibold))
                
                Text("https://reqres.in/#support-heading")
            }
            
            Spacer()
            
            Symbols.link
                .font(.system(.title3, design: .rounded))
        }
    }
    
    
    
    var background: some View {
        Theme.background.ignoresSafeArea()
    }
}

private extension DetailView {
    
    //ViewBuilder allows you to return multiple views as 1. Both Texts for example here.
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(user.firstName)
            .font(.system(.subheadline, design: .rounded))
    }
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(user.lastName)
            .font(.system(.subheadline, design: .rounded))
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(user.firstName)
            .font(.system(.subheadline, design: .rounded))
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(user: dev.previewUser)
                .preferredColorScheme(.dark)
            
            DetailView(user: dev.previewUser)
                .preferredColorScheme(.light)
            
        }
        .previewLayout(.sizeThatFits)
        
    }
}
