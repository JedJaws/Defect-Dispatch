//
//  ThirdView.swift
//  DefectDispatch
//
//  Created by Qice Sun on 6/22/22.
//

import SwiftUI

struct ThirdView: View {

    @ObservedObject var speed = Speed()

    var body: some View {
        Text("According to the recommand speed: \(speed.ideal_speed)mph")
        Text("Walk speed: 1-5mph\nBicycle speed: 6-15mph\nCar speed: 16-80mph")



            .padding()
        switch speed.ideal_speed {
        case 1...5:
            Text("You should walk there").font(.largeTitle).fontWeight(.heavy).foregroundColor(Color.orange).italic()
        case 6...15:
            Text("You should take a bicycle").font(.largeTitle).fontWeight(.heavy).foregroundColor(Color.orange).italic()
        case 16...80:
            Text("You should drive there").font(.largeTitle).fontWeight(.heavy).foregroundColor(Color.orange).italic()
        default:
            Text("You will be late!\n There is no way you can arrive the destination in time ").font(.largeTitle).fontWeight(.heavy).foregroundColor(Color.orange).italic()
        }
        
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView(speed:Speed())
    }
}
