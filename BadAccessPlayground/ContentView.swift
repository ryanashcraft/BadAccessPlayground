import SwiftUI

struct ContentView: View {
    func hammerTime(_ i: Int = 0) {
        badAccess {
            print("Iteration \(i)")
            
            DispatchQueue.global().async {
                hammerTime(i + 1)
            }
        }
    }

    var body: some View {
        VStack {
            Image(systemName: "hammer")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Hammer time") {
                hammerTime()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
