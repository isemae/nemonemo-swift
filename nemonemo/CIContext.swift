//
//  CIContext.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/4/24.
//

import Foundation
import UIKit

func getCIImageContext(imageName: String, unitSize: Double) -> [[ColorData]] {
	guard let image = UIImage(named: imageName) else {
		print("Currently no image found")
		return []
	}
	
	print("Pixelating \(imageName)")

	let imageSize = image.size
	let imageWidth = Double(imageSize.width)
	let imageHeight = Double(imageSize.height)
	let imageRatio = imageWidth / imageHeight
	let rectSize = min(imageSize.width, imageSize.height) / unitSize
	
//	let rectSize = CGSize(width: imageWidth / unitSize, height: imageWidth / unitSize)
	
	var colorsRow: [[ColorData]] = []
	for y in stride(from: 0, to: imageHeight, by: Double(rectSize)) {
		var averageColorsWithUUID: [ColorData] = []
		
		for x in stride(from: 0, to: imageWidth, by: Double(rectSize)) {
			let rect = CGRect(x: x, y: y, width: 10, height: 10)
			
			guard let croppedCGArea = image.cgImage?.cropping(to: rect) else {
				fatalError("영역 크롭 실패")
			}
			
			let croppedUIArea = UIImage(cgImage: croppedCGArea)
			
			guard let averageColor = croppedUIArea.averageColor else {
				fatalError("영역 내 평균 색상값 계산 실패")
			}
			
			let colorId = UUID()
			let colorData = ColorData(id: colorId, color: averageColor)
			averageColorsWithUUID.append(colorData)
		}
		colorsRow.append(averageColorsWithUUID)
	}
	return colorsRow
}

extension UIImage {
	var averageColor: UIColor? {
		guard let inputImage = CIImage(image: self) else { return nil }
		
		let extentVector = CIVector(x: inputImage.extent.origin.x , y: inputImage.extent.origin.y, z: inputImage.extent.width, w: inputImage.extent.size.height)
		let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector])!
		let outputImage = filter.outputImage!
		
		var bitmap = [UInt8](repeating: 0, count: 4)
		let context = CIContext(options: nil)
		
		context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
		
		return UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: 1.0)
	}
}
