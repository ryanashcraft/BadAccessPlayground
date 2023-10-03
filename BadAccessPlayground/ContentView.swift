import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "hammer")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hammer time")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
