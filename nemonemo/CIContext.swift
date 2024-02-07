//
//  CIContext.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/4/24.
//

import Foundation
import UIKit

func getCIImageContext(imageName: String, unitSize: Int) -> [[ColorData]] {

	
	var image = UIImage(named: imageName)
	
	if image != nil {
		print("image exists")
	} else {
		print("no image")
	}
	let imageSize = image!.size
	let imageWidth = Int(imageSize.width)
	let imageHeight = Int(imageSize.height)
	
	let rectSize = CGSize(width: unitSize, height: unitSize)
	
	var colorsRow: [[ColorData]] = []
	for y in stride(from: 0, to: imageHeight, by: Int.Stride(rectSize.height)) {
		var averageColorsWithUUID: [ColorData] = []
		
		for x in stride(from: 0, to: imageWidth, by: Int.Stride(rectSize.width)) {
			let rect = CGRect(x: x, y: y, width: Int(rectSize.width), height: Int(rectSize.height))
			
			guard let croppedCGArea = image?.cgImage?.cropping(to: rect) else {
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
