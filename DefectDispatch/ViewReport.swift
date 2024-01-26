//
//  ReportConfirmationPage.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/25/22.
//

import SwiftUI

struct PreviewReport: View {
    @EnvironmentObject var manager: ReportManager
    @EnvironmentObject var report: Report
    @Binding var showingReportPreview: Bool
    @Binding var submitting: Bool
    var body: some View {
        VStack
        {
            HStack {
                Button("Back", action: {showingReportPreview = false})
                Spacer()
                Button("Submit", action: {
                    submitting = true
                })
            }.padding()
            ViewReport()
        }
    }
}

struct ViewReport: View {
    @EnvironmentObject var report: Report
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Report Type:")
                    Spacer()
                    Text(report.type.rawValue)
                }.foregroundColor(.white)
                    .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))

                VStack(alignment: .leading)
                {
                    Text("Severity:")
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text("Severity: " + report.severity.rawValue.capitalized)
                    }
                    .modifier(SeverityButton(severity: $report.severity))
                }
                if report.description != "" {
                    Text("Description:")
                    HStack
                    {
                        Text(report.description)
                        Spacer()
                    }
                        .padding()
                        .border(.gray, width: 2.0)
                }
                
                if report.photo != nil {
                    HStack{
                        Spacer()
                        Image(uiImage: report.photo!)
                            .resizable()
                            .frame(alignment: .center)
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Spacer()
                    }
                } else {
                    HStack{
                        Spacer()
                        Image(systemName: "camera")
                            .resizable()
                            .frame(alignment: .center)
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Spacer()
                    }
                }
                
            }.padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
