//
//  ContentView.swift
//  Words
//
//  Created by Terran Kroft on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    
    var items: [GridItem] {
        [GridItem(.adaptive(minimum: 150))]
    }
    
    @State var selectionMode = false
    
    @Environment(\.colorScheme) var colorScheme
    @State var cards: [Card] = [] 
    @State var selection: [Bool] = []
    var selected: Int {
        selection.filter {
            $0
        }
        .count
    }
    
    var body: some View {
        NavigationView {
            
            Text("Sidebar")
            
            VStack(spacing: 0) {
                
                
                
                
                ScrollView(.vertical) {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: items, spacing: 20) {
                        ForEach(cards) {card in
                            
                            CardView(sideA: card.sideA, sideB: card.sideB, selected: $selection[cards.firstIndex(of: card) ?? 0])
                                .onTapGesture {
                                    if (selectionMode) {selection[cards.firstIndex(of: card) ?? 0].toggle()}
                                }
                        }
                        
                        Text("+")
                            .font(Font.largeTitle)
                            .padding()
                            .frame(width: 140, height: 140)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 0, y: 10)
                            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.gray.opacity(0.3), lineWidth: 3))
                            .onTapGesture {
                                cards.append(Card(sideA: "entropy", sideB: "エントロピ"))
                                             selection.append(false)
                            }
                    }
                    .padding([.horizontal])
                    Spacer(minLength: 20)
                }
                .onChange(of: selectionMode) { _ in

                    selection = selection.map {_ in
                        false
                    }
                }
                
                HStack {
                    Text(selectionMode ? "Selecting" : "Viewing")
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Words")
            .navigationSubtitle("Words to Learn")
                    .toolbar {

                        ToolbarItem(placement: .automatic) {
                            Button(selectionMode ? "Selected (\(selected))" : "Select") {
                                selectionMode.toggle()
                            }
                        }
                    }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 750, height: 750)
    }
}

struct CardView: View {
    @Environment(\.colorScheme) var colorScheme
    var sideA: String
    var sideB: String
    @Binding var selected: Bool
    
    var body: some View {
        VStack(alignment: .center) {
        Text(sideA)
            .font(Font.system(size: 20, weight: .semibold, design: .rounded))
            Divider()
        Text(sideB)
            .font(Font.system(size: 20, weight: .semibold, design: .rounded))

        }
            .foregroundColor(.primary)
            .padding()
            .frame(width: 140, height: 140)
            .background(selected ? Color.blue.opacity(0.2) : Color.orange.opacity(0.1))
        .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color.white.opacity(0.8))
            
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

            .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 0, y: 10)
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(selected ? Color.blue : Color.orange, lineWidth: 3))
    }
}


struct Card: Hashable, Identifiable {
    var id = UUID()
    var sideA: String
    var sideB: String
}
