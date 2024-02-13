//
//  ContentView.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/3/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
	@State private var squareScale: Double = 1.0
	@State private var isEditing = false
	@State private var isEmbossed = false
	@State private var isPixeled = false

	@State private var avgColorsRow: [[ColorData]] = []
	var image = UIImage(named: "punchCat")
	var body: some View {
		ZStack {
			Image("punchCat")
				.resizable()
				.scaledToFit()

			if isPixeled && !isEditing {
				VStack(spacing: 0) {
					ForEach(avgColorsRow, id: \.self) { row in
						HStack(spacing: 0) {
							ForEach(row, id: \.id) { colorTuple in
								ZStack {
									Rectangle()
										.foregroundColor(Color(colorTuple.color))
									if isEmbossed {
										AngularGradient(gradient: Gradient(colors: [.secondary.opacity(0.5), .clear]), center: .center, startAngle: .degrees(-90), endAngle: .degrees(270))
									}
								}
							}
						}
					}
				}
				.onChange(of: squareScale) {
					DispatchQueue.global().async {
						avgColorsRow = getCIImageContext(imageName: "punchCat", unitSize: squareScale)
					}
				}
				.onAppear() {
					DispatchQueue.global().async {
						avgColorsRow = getCIImageContext(imageName: "punchCat", unitSize: squareScale)
					}
				}
			}
		}
		.frame(width: image!.size.width, height: image!.size.height)
		
		HStack {
			Toggle(isOn: $isPixeled) {
				Text("Pixelate")
			}
			Toggle(isOn: $isEmbossed) {
				Text("Emboss")
			}
		}
		ScaleSlider(isEditing: $isEditing, squareScale: $squareScale)
	}
}

struct ScaleSlider: View {
	@Binding var isEditing: Bool
	@Binding var squareScale: Double
	var body: some View {
		Slider(value: $squareScale, in: 1...50, onEditingChanged: { editing in
			isEditing = editing
		})
		Text("\(Int(squareScale))")
	}
}
//#Preview {
//	ContentView(isEditing: <#Binding<Bool>#>, squareScale: <#Binding<CGFloat>#>)
//}
