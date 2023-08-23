//
//  MeView.swift
//  HotProspects
//
//  Created by Julian Saxl on 2023-08-20.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "JS"
    @State private var email = "j.s@mail.com"
    @State private var qrCode = UIImage()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writePhotoToAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name) {_ in updateCode() }
            .onChange(of: email) {_ in updateCode() }
        }
    }
    
    func generateQrCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let output = filter.outputImage {
            if let cgimage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgimage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQrCode(from: "\(name)\n\(email)")
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
