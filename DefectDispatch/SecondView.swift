import SwiftUI

struct SecondView: View {
    @State var total_mileage = ""
    @State var arriving_time = ""
    @ObservedObject var speed = Speed()
    @AppStorage("speed") var saved_speed:Double = 0
    var body: some View {
        Text("Hello, Second View!")
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundColor(Color.blue)
        Form {
            Section {
                TextField("total mileage(mile)", text: $total_mileage)
                TextField("time left(minute)", text: $arriving_time)
            }
            VStack {
                Button(action: {
                    speed.total_mileage = Double(total_mileage) ?? 0
                    speed.arriving_time = Double(arriving_time) ?? 0
                    speed.calculate_ideal_speed()
                    
                    saved_speed = speed.ideal_speed

                }, label: {
                    Text("Calculate   and   save   the   speed")
                }).buttonStyle(ThemeAnimationStyle())
            }
        }
        
        Text("Min average speed:\(saved_speed) mph")
            .padding()
        

        
        Spacer()
        NavigationLink(destination: ThirdView(speed: speed)) {
            Text("View travel advice")
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}

struct ThemeAnimationStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title2)
            .foregroundColor(Color.white)
            .frame(height: 50, alignment: .center)
            .background(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            .cornerRadius(8)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) // <- change scale value as per need. scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}
