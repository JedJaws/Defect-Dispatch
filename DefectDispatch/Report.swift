//
//  Report.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/13/22.
//

import Foundation
import CoreLocation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

enum ReportType: String, CaseIterable, Identifiable, Codable {
    static var allCases: [ReportType] {
        return [.pothole, .suggestion, .brokenLight]
    }
    case pothole = "Pothole"
    case suggestion = "Suggestion"
    case brokenLight = "Broken Streetlight"
    case undefined = "Select Report type"
    var id: Self { self }
}

enum Severity: String, CaseIterable, Identifiable, Codable {
    static var allCases: [Severity] {
        return [.high, .medium, .low]
    }
    case high = "High";
    case medium = "Medium";
    case low = "Low";
    case unknown = "Estimate Severity";
    var id: Self { self }
}

class Report: ObservableObject, Identifiable, Codable, NSCopying {
    var id: UUID = UUID()
    @Published var name: String
    @Published var address: String
    var date: Date
    @Published var type: ReportType;
    @Published var severity: Severity
    @Published var description: String
    @Published var photo: UIImage?
    
    var valid: Bool {
        return severity != .unknown && type != .undefined && name != "" && address != ""
    }
    
    init() {
        date = Date.now
        type = ReportType.undefined
        severity = Severity.unknown
        description = ""
        name = ""
        address = ""
        photo = nil
    }
    func reinit() {
        id = UUID()
        date = Date.now
        type = ReportType.undefined
        severity = Severity.unknown
        description = ""
        name = ""
        address = ""
        photo = nil
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let copy = try! decoder.decode(Report.self, from:encoder.encode(self))
        return copy
    }
    func printType()
    {
        print(type.rawValue)
    }
    // Based on https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties
    enum CodingKeys: CodingKey {
        case id, name, address, date, type, severity, description, photo
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        date = try container.decode(Date.self, forKey: .date)
        type = try container.decode(ReportType.self, forKey: .type)
        severity = try container.decode(Severity.self, forKey: .severity)
        description = try container.decode(String.self, forKey: .description)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(date, forKey: .date)
        try container.encode(type, forKey: .type)
        try container.encode(severity, forKey: .severity)
        try container.encode(description, forKey: .description)

    }
}
