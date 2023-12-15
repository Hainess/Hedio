//
//  UIImage+Buffer.swift
//  HHFoundationKit
//
//  Created by whh on 2023/8/1.
//

import Foundation
import CoreMedia

extension UIImage {
    
    private static let sampleBufferTimescale: Int32 = 600
    
    private func getTimingInfo(frameIndex: Int, framesPerSecond: Double) -> CMSampleTimingInfo {
        let frameDuration: Int = Int(Double(UIImage.sampleBufferTimescale) / framesPerSecond)
        
        var timingInfo = CMSampleTimingInfo()
        timingInfo.presentationTimeStamp = CMTimeMake(value: Int64(frameDuration * frameIndex),
                                                      timescale: UIImage.sampleBufferTimescale)
        timingInfo.duration = CMTimeMake(value: Int64(frameDuration),
                                         timescale: UIImage.sampleBufferTimescale)
        timingInfo.decodeTimeStamp = CMTime.invalid
        
        return timingInfo
    }
    
    /**
     Convert `UIImage` to `CMSampleBuffer` and set corresponding sample timing info.
     
     `CMSampleBuffer` wraps `CVPixelBuffer` data and adds sample timing info relative to other samples in a set.
     
     With provided `frameIndex` and `framesPerSecond` the following timing rules apply:
     * Sample duration (seconds): `1 / framesPerSecond`
     * Sample start time: `frameIndex / framesPerSecond`
     
     - Parameter frameIndex: index of the frame along other frames in a sample set. By default is 0.
     - Parameter framesPerSecond: FPS rate of a sample set. By default is 24.
     
     - Precondition: `frameIndex` must be greater than or equal to 0
     - Precondition: `framesPerSecond` must be greater than 0
     
     - Returns: `CMSampleBuffer` with calculated timing info or `nil`, if unable to convert
     */
    public func toSampleBuffer(frameIndex: Int = 0, framesPerSecond: Double = 24) -> CMSampleBuffer? {
        guard frameIndex >= 0 && framesPerSecond > 0
            else { return nil }
        
        guard let pixelBuffer = self.toPixelBuffer()
            else { return nil }

        var formatDesc: CMFormatDescription? = nil
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault,
                                                     imageBuffer: pixelBuffer,
                                                     formatDescriptionOut: &formatDesc)

        var timingInfo = getTimingInfo(frameIndex: frameIndex, framesPerSecond: framesPerSecond)
        var sampleBuffer: CMSampleBuffer? = nil
        CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault,
                                                 imageBuffer: pixelBuffer,
                                                 formatDescription: formatDesc!,
                                                 sampleTiming: &timingInfo,
                                                 sampleBufferOut: &sampleBuffer)
        
        return sampleBuffer
    }

}


extension UIImage {
    
    /**
     Convert `UIImage` to `CVPixelBuffer`.
     
     This method copies source `UIImage` data to a `CVPixelBuffer`.
     
     - Returns: `CVPixelBuffer` or `nil`, if unable to convert data
     */
    public func toPixelBuffer() -> CVPixelBuffer? {
        guard let cgImage = self.cgImage
            else { return nil }

        let frameSize = CGSize(width: cgImage.width,
                               height: cgImage.height)
        
        var pixelBuffer: CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(frameSize.width),
                                         Int(frameSize.height),
                                         kCVPixelFormatType_32BGRA,
                                         nil,
                                         &pixelBuffer)
        
        if status != kCVReturnSuccess {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data,
                                width: Int(frameSize.width),
                                height: Int(frameSize.height),
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
                                space: rgbColorSpace,
                                bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }

}

extension CVPixelBuffer {
    
    /**
     Convert `CVPixelBuffer` to `UIImage`
     
     - Parameter orientation: target image orientation, by default is `.up`
     - Returns: `UIImage` instance or `nil`, if unable to create
     */
    public func toImage(orientation: CGImagePropertyOrientation = .up) -> UIImage? {
        let ciImage = CIImage(cvPixelBuffer: self).oriented(orientation)
        let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)
        return cgImage != nil ? UIImage(cgImage: cgImage!) : nil
    }
    
}

