//
//  ContentView.swift
//  SFSymbolsPickerExample
//
//  Created by Diego Freniche Brito on 25/8/21.
//

import SwiftUI
import SFSymbolsPicker

struct ContentView: View {
    @State private var symbolName = "magnifyingglass"
    @State private var copyToPasteboard = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                NavigationLink(destination:
                        SFSymbolsPicker { symbol in
                            symbolName = symbol
                            if copyToPasteboard {
                                let pasteBoard = UIPasteboard.general
                                pasteBoard.string = symbol
                            }
                        }
                    ) {
                        Text("Select Symbol")
                    }.navigationBarTitle(Text(symbolName))
                
                Spacer()
                
                Toggle("Copy to pasteboard", isOn: $copyToPasteboard)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
