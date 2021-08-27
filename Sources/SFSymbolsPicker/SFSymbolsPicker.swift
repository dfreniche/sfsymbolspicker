import SwiftUI

public struct SFSymbolsPicker: View {
    private var completion: ((String) -> Void)?
    @State private var tileColor = Color.white
    @State private var tileBackgroundColor = Color.gray
    @State private var filterText = ""

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var symbols: [SFSymbol] = sfSymbolNames
                                        .map { SFSymbol.init(symbolName: $0) }
                                        .filter { !($0.symbolName.starts(with: "Usage")) }
    
    // cached for filtering
    let originalSymbols = sfSymbolNames
        .map { SFSymbol.init(symbolName: $0) }
        .filter { !($0.symbolName.starts(with: "Usage")) }
    
    public init(completion: ((String) -> Void)? = nil) {
        self.completion = completion
    }
    
    public var body: some View {
        ScrollView {
            // Filter Text
            
            TextField("Filter \(symbols.count) icons, \(sfSymbolNames.count - symbols.count) restricted", text: $filterText)
                .onChange(of: filterText) { newValue in
                    guard !newValue.isEmpty else {
                        self.symbols = self.originalSymbols
                        return
                    }
                    
                    self.symbols = self.originalSymbols.filter { $0.symbolName.contains(newValue.lowercased()) }
                }
                .padding()
                .border(Color.gray, width: 1.0)
                .padding(.all, 10)

            // Color selector
            HStack {
                ColorPicker("Foreground", selection: $tileColor)
                Spacer(minLength: 20.0)
                ColorPicker("BackGround", selection: $tileBackgroundColor)
            }
            .padding()
            .border(Color.gray, width: 1.0)
            .padding(.all, 10)

            // Grid of icons
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(symbols){ symbol in
                    Button(action: {
                        completion?(symbol.symbolName)
                    }, label: {
                        VStack {
                            Image(systemName: symbol.symbolName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text(symbol.symbolName)
                                .font(.footnote)
                                .lineLimit(2)
                        }
                    })
                    .foregroundColor(tileColor)
                    .padding()
                    .background(tileBackgroundColor)
                    .cornerRadius(5)
                }
            }
            .padding(.all, 10)
        }
        .navigationTitle("SF Symbols Picker")
    }
}

struct SFSymbol: Identifiable {
    let symbolName: String
    let id = UUID()
}

struct SFSymbolsPicker_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolsPicker()
    }
}
