//
//  ProfileView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct ProfileView: View {
    
    private var isOwnProfile: Bool = true
    @State private var postsFilter: ProfileViewFilter = .xpression
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Real Name")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Text("Username")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            ProfilePictureSmall()
                        }
                        Text("Profil Description")
                            .font(.footnote)
                        
                        Text("XXX Followers")
                            .font(.footnote)
                            .fontWeight(.thin)
                        
                        if isOwnProfile {
                            HStack {
                                SmallButton(
                                    label: "Settings_Key",
                                    color: .red,
                                    action: {
                                        // MARK: TO SETTINGS
                                    }
                                )
                                
                                Spacer()
                                
                                Text("X")
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                                    .font(.system(size: 40))
                                
                                Spacer()
                                
                                NavigationLink(
                                    destination: EditProfileView(),
                                    label: {
                                        Text("Edit_Key")
                                            .foregroundStyle(.blue)
                                            .fontWeight(.semibold)
                                            .frame(width: 100, height: 40)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.blue, lineWidth: 1)
                                            }
                                    }
                                )
                            }
                        } else {
                            Button(action: {
                                
                            }, label: {
                                Text("Follow_Key")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.blue, lineWidth: 1)
                                    }
                            })
                        }
                        
                        Picker(selection: $postsFilter.animation(), label: Text("Profile_Filter")) {
                            ForEach(ProfileViewFilter.allCases) { filter in
                                Text(filter.title).tag(filter)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        if postsFilter == .xpression {
                            LazyVStack {
                                ForEach(0...25, id: \.self) { post in
                                    FeedRow(dummyFeedViewModel)
                                }
                            }
                        } else if postsFilter == .xchange {
                            LazyVStack {
                                
                            }
                        } else if postsFilter == .xtacts {
                            VStack {
                                LazyVStack {
                                    ForEach(0...25, id: \.self) { post in
                                        ProfilePreviewRow()
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("ConXdentity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Text("Translated Texts")
                            .font(.caption2)
                    })
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
