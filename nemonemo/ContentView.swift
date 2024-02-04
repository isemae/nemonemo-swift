//
//  ContentView.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/3/24.
//

import SwiftUI

struct ContentView: View {
	@State private var squareScale = 30
	@State private var squareSize = UIScreen.main.bounds.width
	let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .gray]
	
	var body: some View {
		let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Int(squareScale))
		ZStack {
			Image("nemoCat")
//			Image(systemName: "nemoCat")
				.resizable()
				.scaledToFit()
				.background(.black)
			LazyVGrid(columns: columns, spacing: 0) {
				ForEach(0..<(Int(squareScale) * Int(squareScale) * 3)) { i in
					ZStack {
						Rectangle()
							.frame(width: squareSize / CGFloat(squareScale), height: squareSize / CGFloat(squareScale))
//							.foregroundColor(allColors.randomElement()!)
							.foregroundStyle(.ultraThinMaterial)
						
//						RadialGradient(gradient: Gradient(colors: [.clear, .black]), center: .center, startRadius: 0, endRadius: squareSize / CGFloat(squareScale))
						AngularGradient(gradient: Gradient(colors: [.secondary.opacity(0.5), .clear]), center: .center, startAngle: .degrees(-90), endAngle: .degrees(270))
//							.blur(radius: squareSize / CGFloat(squareScale) / 10)
//							.frame(width: squareSize / CGFloat(squareScale), height: squareSize / CGFloat(squareScale))
					}
				}
			}
			.frame(width: .infinity, height: .infinity)
		}
	}
}

#Preview {
	ContentView()
}
