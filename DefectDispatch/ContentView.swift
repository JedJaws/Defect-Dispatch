
import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var manager = ReportManager.load()
    var body: some View {
        TabView {
            ReportList()
                .tabItem {
                    Image(systemName: "car")
                    Text("Defects")
                }
            ReportingInterface()
                .tabItem{
                    Image(systemName: "plus")
                    Text("Add Defect")
                }
            
            NavigationView {
                        VStack {
                            NavigationLink(destination: SecondView()) {
                                Text("Welcome")
                                .frame(minWidth: 0, maxWidth: 300)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                                .font(.title)
                        }.buttonStyle(ThemeAnimationStyle())
                      }
                    }.tabItem{
                        Image(systemName: "arrowshape.zigzag.right")
                        Text("Speed calculate")
                    }
            
        }.environmentObject(manager)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

