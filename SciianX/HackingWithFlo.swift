//
//  HackingWithFlo.swift
//  SciianX
//
//  Created by Philipp Henkel on 27.02.24.
//

import SwiftUI

enum CharacterType: String {
    case witcher, sourceress, bard, animal, monster
}

struct Character: Hashable, Identifiable {
    let name: String
    let type: CharacterType
    
    let id = UUID()
}

struct HackingWithFlo: View {
    @State private var characters: [Character] = [
        .init(name: "Triss", type: .sourceress)
    ]
    @State private var scrollContentHeight: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(systemName: "figure.2")
                Spacer()
                ScrollView {
                    ForEach(characters) { character in
                        Text(character.name)
                    }
                    .getSize {
                        scrollContentHeight = $0.height
                    }
                }
                .border(.black)
                .frame(height: scrollContentHeight)
                .defaultScrollAnchor(.bottom)
                
                Button("Add charcter") {
                    self.characters.append(self.getRandomCaharcter())
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    
    private func getRandomCaharcter() -> Character {
        [
            Character(name: "Philippa", type: .sourceress),
            Character(name: "Leto", type: .witcher),
            Character(name: "Rittersport", type: .bard),
            Character(name: "Vesemir", type: .witcher),
            Character(name: "Geralt", type: .witcher),
        ]
            .randomElement()!
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizeModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
    
    func body(content: Content) -> some View {
        content.overlay(sizeView)
    }
}

extension View {
    func getSize(perform: @escaping (CGSize) -> ()) -> some View {
        self
            .modifier(SizeModifier())
            .onPreferenceChange(SizePreferenceKey.self) {
                perform($0)
            }
    }
}

#Preview {
    HackingWithFlo()
}
