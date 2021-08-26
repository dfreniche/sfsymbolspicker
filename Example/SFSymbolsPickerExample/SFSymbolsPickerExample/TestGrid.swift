//
//  TestGrid.swift
//  TestGrid
//
//  Created by Diego Freniche Brito on 26/8/21.
//

import Foundation
import SwiftUI

struct TestGrid: View {
    private var gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 20) {
                ForEach((1...100), id: \.self) {
                    Text("\($0)")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                        .background(Color.red)
                }
            }
            .padding(.all, 10)
        }
    }
}
