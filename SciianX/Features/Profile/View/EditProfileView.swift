//
//  EditProfileView.swift
//  SciianX
//
//  Created by Philipp Henkel on 23.01.24.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name: String = "Philipp Henkel"
    @State private var description: String = "Random Description"
    
    var body: some View {
        ZStack {
            BackgroundImage()
            
            Form {
                ZStack {
                    ProfilePictureBig()
                    Button(action: {
                        // MARK: EDIT PICTURE ACTION
                    }, label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                }
                .listRowBackground(Color.clear)
                .padding(.vertical, -20)
                
                Section("User Info") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
                .textFieldStyle(.roundedBorder)
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity)
                
                Section("Account Settings") {
                    BigButton(
                        label: "Delete Account",
                        color: .red,
                        action: {
                            // MARK: DELETE ACCOUNT ACTION
                        }
                    )
                }
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.blue)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    EditProfileView()
}
