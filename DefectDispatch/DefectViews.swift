//
//  DefectViews.swift
//  DefectDispatch
//
//  Created by Jed Verry on 6/20/22.
//

import SwiftUI



struct AddDefects: View {
    @SceneStorage("defectwalkName") var defectName: String = ""
    @SceneStorage("defectAddress") var defectAddress: String = ""
    @EnvironmentObject var manager: ReportManager
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                Text("New Defect")
                    .bold()
                    .font(.largeTitle)
                }
                .padding(.bottom, 30)
                
                HStack{
                Text("Add a picture")
                        .bold()
                }
                .padding(.bottom, 20)
                Spacer()

                HStack {
                    Text("Defect Name")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("Defect name", text: $defectName)
                        .modifier(TextEntry())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Defect address")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                TextEditor(text: $defectAddress)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.reports.append(Report())
                }) {
                    Text("Submit")
                        .modifier(ButtonDesign())
                }
                Spacer()
            }
            .padding()
        }
    }
}
