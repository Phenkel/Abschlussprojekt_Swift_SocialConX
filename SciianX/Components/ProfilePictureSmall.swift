//
//  ProfilePictureSmallView.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.01.24.
//

import SwiftUI

struct ProfilePictureSmall: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Image("testPic")
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
                .overlay(content: {
                    Circle()
                        .stroke(lineWidth: 3.0)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                })
        })
    }
}

#Preview {
    ProfilePictureSmall()
}
