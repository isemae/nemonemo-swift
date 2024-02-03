//
//  ContentView.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/3/24.
//

import SwiftUI

struct ContentView: View {
	@State private var squareScale = 20
	@State private var squareSize = UIScreen.main.bounds.width
	let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .brown, .gray]
	
	var body: some View {
		let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Int(squareScale))
		ZStack {
			Image(systemName: "trash")
			LazyVGrid(columns: columns, spacing: 0) {
				ForEach(0..<(Int(squareScale) * Int(squareScale) * 3)) { i in
					ZStack {
						Rectangle()
							.frame(width: squareSize / CGFloat(squareScale), height: squareSize / CGFloat(squareScale))
							.foregroundStyle(allColors.randomElement()!)
							.foregroundStyle(.ultraThickMaterial)
						Rectangle()
							.foregroundStyle(.ultraThickMaterial)
							.opacity(0.4)
					}
				}
			}
			.opacity(0.5)
		}
			.frame(width: .infinity, height: .infinity)
//		)
	}
}

#Preview {
	ContentView()
}
