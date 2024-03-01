//
//  ProfilePreviewView.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.01.24.
//

import SwiftUI

struct ProfilePreviewRow: View {
    var body: some View {
        VStack {
            HStack {
                ProfilePictureSmallView()
                
                VStack {
                    Text("Username")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text("Real Name")
                        .font(.footnote)
                        .fontWeight(.thin)
                }
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("Follow")
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        }
                })
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            
            Divider()
        }
    }
}

#Preview {
    ProfilePreviewRow()
}
