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
    
    @State var multiSelectionMode = false
    
    @Environment(\.colorScheme) var colorScheme
    @State var cards: [Card] = []
    @State var selectedCard: Card? = nil
    @State var selection: [Bool] = []
    var selected: Int {
        selection.filter {
            $0
        }
        .count
    }
    var selectedIndex: Int? {
        selection.firstIndex(of: true)
    }
    
    var body: some View {
        NavigationView {
            
            Text("Sidebar")
            
            HStack(alignment: .top, spacing: 0) {
                
                
                
                
                ScrollView(.vertical) {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: items, spacing: 20) {
                        ForEach(cards) {card in
                            
                            CardView(card: card, selected: $selection[cards.firstIndex(of: card)!])
                                .onTapGesture {

                                        // single selection mode
                                        var currentSelection = selection[cards.firstIndex(of: card) ?? 0]
                                        currentSelection.toggle()
                                        selection = selection.map {_ in false}
                                        selection[cards.firstIndex(of: card) ?? 0] = currentSelection
                                    
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
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .onChange(of: multiSelectionMode) { _ in

                    selection = selection.map {_ in
                        false
                    }
                }
                
                
                VStack(alignment: .center, spacing: 20) {
                        HStack(alignment: .top) {
                            Text("Properties").font(Font.system(.title, design: .rounded)).bold().foregroundColor(.gray)
                            Spacer()
                        }
                        
                        if let index = selectedIndex {
                            VStack(alignment: .center) {
                                Text(cards[index].sideA)
                                .font(Font.system(size: 20, weight: .semibold, design: .rounded))
                                Divider()
                                Text(cards[index].sideB)
                                .font(Font.system(size: 20, weight: .semibold, design: .rounded))

                            }
                                .foregroundColor(.primary)
                                .padding()
                                .frame(width: 250, height: 250)
                            .background(colorScheme == .dark ? Color.black.opacity(0.8) : Color.white.opacity(0.8))
                                
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                                .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 0, y: 10)
                                .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.orange, lineWidth: 3))
                            
                            HStack {
                                Text("Side A").font(.system(.body, design: .rounded))
                                Spacer()
                                TextField("Side A", text: .constant(cards[index].sideA))
                            }
                            
                            HStack {
                                Text("Side B").font(.system(.body, design: .rounded))
                                Spacer()
                                TextField("Side B", text: .constant(cards[index].sideB))
                            }
                            
                            
                                HStack {
                                    Text("Color").font(.system(.body, design: .rounded))
                                    Spacer()
                                    Circle().fill(Color.red).frame(width: 20, height: 20)
                                    Circle().fill(Color.orange).frame(width: 20, height: 20).overlay(Circle().stroke(Color.primary, lineWidth: 2))
                                    Circle().fill(Color.yellow).frame(width: 20, height: 20)
                                    Circle().fill(Color.green).frame(width: 20, height: 20)
                                    Circle().fill(Color.blue).frame(width: 20, height: 20)
                                    Circle().fill(Color.purple).frame(width: 20, height: 20)
                                    Circle().fill(Color.pink).frame(width: 20, height: 20)
                                    Spacer()
                                }
                            
                            HStack {
                                Text("Stats").font(Font.system(.title, design: .rounded)).foregroundColor(.secondary)
                                Spacer()
                            }
                            
                                
                                
                            Spacer()
                        } else {
                            HStack {
                            Text("No cards selected.")
                            Spacer()
                            }
                        }
                        
                       
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: 300)
                    
                
                
                
            }
            .navigationTitle("Words")
            .navigationSubtitle("Words to Learn")
                    .toolbar {

                        ToolbarItem(placement: .automatic) {
                            Button(multiSelectionMode ? "Selected (\(selected))" : "Select") {
                                multiSelectionMode.toggle()
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
    var card: Card
    @Binding var selected: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Text(card.sideA)
            .font(Font.system(size: 20, weight: .semibold, design: .rounded))
            Divider()
            Text(card.sideB)
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
