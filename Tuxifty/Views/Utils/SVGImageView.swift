//
//  SVGImageView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 09/04/2026.
//

import SwiftUI
import SwiftDraw

struct SVGImageView: View {
    let url: URL
    
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 40, height: 40)
            } else {
                ProgressView()
            }
        }
        .task {
            await loadSVG()
        }
    }

    func loadSVG() async {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                return;
            }

            guard let svg = SVG(data: data) else {
                return;
            }

            image = svg.rasterize()
        } catch {
            print("Error: \(error)")
        }
    }
}
#Preview {
    SVGImageView(url: URL(string: "https://cdn.intra.42.fr/achievement/image/40/SCO001.svg")!)
}
