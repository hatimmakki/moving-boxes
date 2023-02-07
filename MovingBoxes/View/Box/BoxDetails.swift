//
//  BoxDetails.swift
//  MovingBoxes
//
//  Created by Hatim Hoho on 7/2/2023.
//

import SwiftUI

struct BoxDetails: View {
    @ObservedObject var box: Box

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Box name", text: $box.name)
                .padding()
            TextField("Box note", text: $box.note)
                .padding()
            Image(uiImage: generateQRCode(from: box.id!)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .navigationBarTitle("Box Details")
    }

    private func generateQRCode(from string: String) -> UIImage {
        let data = string.data(using: .ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return UIImage()
    }
}


struct BoxDetails_Previews: PreviewProvider {
    static var previews: some View {
        BoxDetails()
    }
}
