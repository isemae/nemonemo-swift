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
	@State private var currentImageName: String = "punchCat"
	@State private var avgColorsRow: [[ColorData]] = []
	var body: some View {
		var image = UIImage(named: currentImageName)
		selectImageButtons()
		GeometryReader { geometry in
			Image(currentImageName)
				.resizable()
				.scaledToFit()
				.overlay(
					Group {
						if isPixeled && !isEditing {
							PixelatedImageView()
								.frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
								.onChange(of: squareScale) {
									DispatchQueue.global().async {
										pixelateCurrentImage()
									}
								}
								.onChange(of: currentImageName) {
									DispatchQueue.global().async {
										pixelateCurrentImage()
									}
								}
								.onAppear() {
									DispatchQueue.global().async {
										pixelateCurrentImage()
									}
								}
						}
					}
				)
				.frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
				.padding()
			
			
		}
		ImageProcessingToggles(isEmbossed: $isEmbossed, isPixeled: $isPixeled)
		ScaleSlider(isEditing: $isEditing, squareScale: $squareScale)
	}
	
	func selectImageButtons() -> some View {
		HStack {
			ForEach(Gatos.allCases, id: \.self) { gato in
				Spacer()
				VStack {
					Text(gato.gato.desc)
						.font(.caption)
					Button(action: { setCurrentImage(imageName: gato.gato.name ) }) {
						Image(systemName: gato.gato.symbol)
							.foregroundColor(.accentColor)
							.font(.title)
					}
					.frame(width: 50, height: 50)
					.background()
					.cornerRadius(10)
					.shadow(radius: 5)
				}
				Spacer()
			}
		}
	}
	
	func PixelatedImageView() -> some View {
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
	}
	
	func pixelateCurrentImage() {
		avgColorsRow = getCIImageContext(imageName: currentImageName, unitSize: squareScale)
	}
	
	func setCurrentImage(imageName: String) {
		currentImageName = imageName
	}
}

struct ImageProcessingToggles: View {
	@Binding var isEmbossed: Bool
	@Binding var isPixeled: Bool
	
	var body: some View {
		HStack {
			Toggle(isOn: $isPixeled) {
				Text("Pixelate")
			}
			Toggle(isOn: $isEmbossed) {
				Text("Emboss")
			}
		}
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

#Preview {
	ContentView()
}
