//
//  Speed.swift
//  DefectDispatch
//
//  Created by Qice Sun on 6/12/22.
//

import Foundation

class Speed: ObservableObject{
  var total_mileage: Double
  var arriving_time: Double
  @Published var ideal_speed: Double = 0
    @Published var print_out: String = ""

  init() {
    self.total_mileage = 0
    self.arriving_time = 0
  }

  func calculate_ideal_speed(){
      var temp: Double
      let ratio: Double = 60
      temp = total_mileage/arriving_time * ratio
      ideal_speed = temp
      
  }
    

}
