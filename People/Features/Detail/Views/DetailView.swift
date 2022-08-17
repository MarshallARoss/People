//
//  DetailView.swift
//  People
//
//  Created by Marshall  on 8/15/22.
//

import SwiftUI

struct DetailView: View {
    
    let user: UserDetailResponse
    @State private var userInfo: UserDetailResponse?
    
    
    var body: some View {
        ZStack {
            background
            ScrollView {
                
                VStack(alignment: .leading, spacing: 18){
                    
                   avatarImage
                    
                    Group {
                    userList
                    link
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 19)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

                }
                .padding()
            }
        }
        .navigationBarTitle(user.data.firstName ?? "Details")
        .onAppear {
            do {
                userInfo = try StaticJSONMapper.decode(file: "SingleUser", type: UserDetailResponse.self)
            } catch {
                //Handle Errors
                print(error)
            }
        }
    }
}

private extension DetailView {
    
    var userList: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            PillView(id: userInfo?.data.id ?? 0)
            
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
    
    @ViewBuilder
    var avatarImage: some View {
        if let avatarAbsoluteString = userInfo?.data.avatar,
           let avatarURL = URL(string: avatarAbsoluteString) {
            AsyncImage(url: avatarURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(width: .infinity, height: 250)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = userInfo?.support.url,
           let supportURL = URL(string: supportAbsoluteString),
           let supportText = userInfo?.support.text {
        
        Link(destination: supportURL) {
            VStack(alignment: .leading, spacing: 8) {
                Text(supportText)
                    .foregroundColor(Theme.text)
                    .font(.system(.body, design: .rounded).weight(.semibold))
                
                Text(supportAbsoluteString)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Symbols.link
                .font(.system(.title3, design: .rounded))
        }
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
        
        Text(userInfo?.data.firstName ?? "-")
            .font(.system(.subheadline, design: .rounded))
    }
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(userInfo?.data.lastName ?? "-")
            .font(.system(.subheadline, design: .rounded))
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(.system(.body, design: .rounded).weight(.semibold))
        
        Text(userInfo?.data.email ?? "-")
            .font(.system(.subheadline, design: .rounded))
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                DetailView(user: dev.previewUserDetail)
                    .preferredColorScheme(.dark)
                
                DetailView(user: dev.previewUserDetail)
                    .preferredColorScheme(.light)
                
            }
            .previewLayout(.sizeThatFits)
        }
        
    }
}
