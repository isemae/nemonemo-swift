//
//  ContentView.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/3/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
	@State private var squareScale = 30
	@State private var squareSize = UIScreen.main.bounds.width
	let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .gray]
	@State private var avgColorsRow: [[ColorData]] = []
	@State private var rowColors: [ColorData] = []
	
	var body: some View {
		let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Int(squareScale))
		//	let imageRect = getCIImageContext(imageName: "bongo-cat", unitSize: Int(UIScreen.main.bounds.width / 30.0))
		//		ZStack {
		//			LazyVGrid(columns: columns, spacing: 0) {
		//				ForEach(averageColors, id: \.self) { color in
		//					Rectangle()
		//							.frame(width: squareSize / CGFloat(squareScale), height: squareSize / CGFloat(squareScale))
		//							.foregroundColor(Color(color))
		//				}
		//			}
		VStack(spacing: 0) {
			ForEach(avgColorsRow, id: \.self) { row in
				HStack(spacing: 0) {
					ForEach(row, id: \.id) { colorTuple in
						//					ZStack {
						Rectangle()
							.frame(width: squareSize / CGFloat(squareScale), height: squareSize / CGFloat(squareScale))
							.foregroundColor(Color(colorTuple.color))
						
						
						//							.foregroundColor(allColors.randomElement()!)
						//							.foregroundStyle(.ultraThinMaterial)
						
						//						AngularGradient(gradient: Gradient(colors: [.secondary.opacity(0.5), .clear]), center: .center, startAngle: .degrees(-90), endAngle: .degrees(270))
						//					}
					}
				}
			}
		}
			.onAppear() {
				avgColorsRow = getCIImageContext(imageName: "punchCat", unitSize: 20)
			
		}
	}
	
}



#Preview {
	ContentView()
}
