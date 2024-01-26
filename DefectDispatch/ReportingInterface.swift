import SwiftUI

struct ReportingInterface: View {
    
    @EnvironmentObject var manager: ReportManager;
    @StateObject var report: Report = .init()
    @State private var showingReportPreview: Bool = false;
    @State private var showingErrorMessage: Bool = false;
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerDisplay = false
    
    @State private var submitting: Bool = false;
    var body: some View {
        GeometryReader { _ in
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        NavigationLink(destination: PreviewReport(showingReportPreview: $showingReportPreview, submitting: $submitting).environmentObject(report).environmentObject(manager), isActive: $showingReportPreview) {
                            EmptyView()
                        }
                            .navigationBarBackButtonHidden(true)
                            .onChange(of: submitting) { newValue in
                                manager.reports.append(report.copy() as! Report)
                                report.reinit()
                                ReportManager.save(manager)
                                showingReportPreview = false
                            }
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Preview Report", action: {
                                if report.valid
                                {
                                    showingReportPreview = true;
                                } else
                                {
                                    showingErrorMessage = true
                                }
                            }).alert("Error!", isPresented: $showingErrorMessage, actions: {}, message: {
                                Text("All reports must have a name, a severity, and a type!")
                            })
                            .modifier(RoundedButton(padding: 5, background: .green, cornerRadius: 40))
                        }
                    }
                    HStack {
                        Text("Report Name")
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    HStack {
                        TextField("Report name", text: $report.name)
                            .modifier(TextEntry())
                            .foregroundColor(.black)
                        Spacer()
                    }

                    Menu {
                        Picker("Report Type", selection: $report.type, content: {
                            ForEach(ReportType.allCases) { reportType in
                                Text(reportType.rawValue)
                            }
                        })
                    } label: {
                        HStack
                        {
                            Text("Report Type:")
                            Spacer()
                            Text(report.type.rawValue)
                        }.foregroundColor(.white)
                            .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                    }
                    HStack {
                        HStack {
                            Image(systemName: "camera.aperture")
                            Button("Take Photo"){
                                self.sourceType = .camera
                                self.isImagePickerDisplay.toggle()
                            }
                        }
                        .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                        HStack {
                            Image(systemName: "photo")
                            Button("Photo Library"){
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }
                        }
                        .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                    }
                    .sheet(isPresented: self.$isImagePickerDisplay){
                        ImagePickerView(selectedImage: self.$report.photo, sourceType: self.sourceType)
                    }
                    
                    if report.photo != nil {
                        Image(uiImage: report.photo!)
                            .resizable()
                            .aspectRatio(contentMode:.fit)
                            .frame(width: 150, height: 150)
                    } else {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                    }

                    HStack {
                        Text("Report address")
                            .bold()
                        Spacer()
                    }
                    HStack {
                        TextField("Address" ,text: $report.address)
                            .modifier(TextEntry())
                            .foregroundColor(.black)
                        Image(systemName: "location.north.circle").modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                            .rotationEffect(Angle(degrees: 15))
                    }
                    Menu {
                        Picker("Severity Level", selection: $report.severity, content: {
                            ForEach(Severity.allCases) { severity in
                                Text(severity.rawValue.capitalized)
                            }
                        })
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                            Text(report.severity.rawValue.capitalized)
                        }
                        .modifier(SeverityButton(severity: $report.severity))
                    }
                    
                    TextEditor(text: $report.description)
                        .padding()
                        .border(.gray, width: 2.0)
                }.padding()
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}

struct RoundedButton: ViewModifier {
    var padding: CGFloat;
    var background: Color;
    var cornerRadius: CGFloat;
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(background)
            .cornerRadius(cornerRadius)
            .foregroundColor(.white)
    }
}

struct ReportingInterface_Preview: PreviewProvider {
    static var previews: some View {
        ReportingInterface()
    }
}

struct SeverityButton: ViewModifier {
    @Binding var severity: Severity;
    func body(content: Content) -> some View {
        switch(severity)
        {
        case .high:
            content
                .modifier(RoundedButton(padding: 5, background: .red, cornerRadius: 40))
        case .medium:
            content
                .modifier(RoundedButton(padding: 5, background: .yellow, cornerRadius: 40))
                .foregroundColor(.black)
        case .low:
            content
                .modifier(RoundedButton(padding: 5, background: .green, cornerRadius: 40))
        default:
            content
                .modifier(RoundedButton(padding: 5, background: .gray, cornerRadius: 40))
        }
    }
}
