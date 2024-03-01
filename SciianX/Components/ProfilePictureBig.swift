//
//  ProfilePictureBig.swift
//  SciianX
//
//  Created by Philipp Henkel on 19.02.24.
//

import SwiftUI

struct ProfilePictureBig: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Image("testPic")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
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
    ProfilePictureBig()
}
