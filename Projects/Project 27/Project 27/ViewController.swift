//
//  ViewController.swift
//  Project 27
//
//  Created by Julio Braganca on 23/06/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1

        if currentDrawType > 8 {
            currentDrawType = 0
        }

        switch currentDrawType {
        case 0:
            drawRectangle()

        case 1:
            drawCircle()

        case 2:
            drawCheckerboard()

        case 3:
            drawRotatedSquares()

        case 4:
            drawLines()

        case 5:
            drawImagesAndText()

        case 6:
            drawEmoji()

        case 7:
            drawStar()

        case 8:
            drawTwins()

        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var lenght: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2) // 90 deg
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: lenght, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: lenght, y: 50))
                }
                
                lenght *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = image
    }
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let circle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(2)
            
            ctx.cgContext.addEllipse(in: circle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let leftEye = CGRect(x: 125, y: 150, width: 50, height: 50).insetBy(dx: 5, dy: 5)
            let rightEye = CGRect(x: 337, y: 150, width: 50, height: 50).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.orange.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.lightGray.cgColor)
            ctx.cgContext.setLineWidth(0.5)
            
            ctx.cgContext.addEllipse(in: rightEye)
            ctx.cgContext.addEllipse(in: leftEye)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let mouth = CGRect(x: 181, y: 325, width: 150, height: 100).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.orange.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.lightGray.cgColor)
            ctx.cgContext.setLineWidth(0.5)
            
            ctx.cgContext.addEllipse(in: mouth)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawStar() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            //            ctx.cgContext.translateBy(x: 256, y: 256)
            
            ctx.cgContext.move(to: CGPoint(x: 256 , y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 200, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 180, y: 260))
            ctx.cgContext.addLine(to: CGPoint(x: 130, y: 350))
            ctx.cgContext.addLine(to: CGPoint(x: 256, y: 305))
            ctx.cgContext.addLine(to: CGPoint(x: 370, y: 350))
            ctx.cgContext.addLine(to: CGPoint(x: 320, y: 260))
            ctx.cgContext.addLine(to: CGPoint(x: 400, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 300, y: 200))
            ctx.cgContext.addLine(to: CGPoint(x: 256, y: 100))
            
            ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.setLineJoin(.round)
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawTwins() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let adjustment = 21
            
            // T
            ctx.cgContext.move(to: CGPoint( x: 55 + adjustment, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 135 + adjustment, y: 100))
            ctx.cgContext.move(to: CGPoint( x: 95 + adjustment, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 95 + adjustment, y: 300))
            
            // W
            ctx.cgContext.move(to: CGPoint( x: 155 + adjustment, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 170 + adjustment, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 185 + adjustment, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 200 + adjustment, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 215 + adjustment, y: 100))
            
            // I
            ctx.cgContext.move(to: CGPoint( x: 235 + adjustment, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 235 + adjustment, y: 300))
            
            // N
            ctx.cgContext.move(to: CGPoint( x: 255 + adjustment, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 255 + adjustment, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 280 + adjustment, y: 300))
            ctx.cgContext.addLine(to: CGPoint(x: 280 + adjustment, y: 100))
            
            // S
            ctx.cgContext.move(to: CGPoint(x: 380 + adjustment, y: 150))
            ctx.cgContext.addCurve(to: CGPoint(x: 300 + adjustment, y: 150), control1: CGPoint(x: 370 + adjustment, y: 90), control2: CGPoint(x: 310 + adjustment, y: 90))
//            ctx.cgContext.addLine(to: CGPoint(x: 300, y: 175))
            ctx.cgContext.addCurve(to: CGPoint(x: 380 + adjustment, y: 250), control1: CGPoint(x: 290 + adjustment, y: 200), control2: CGPoint(x: 390 + adjustment, y: 200))
            ctx.cgContext.addCurve(to: CGPoint(x: 300 + adjustment, y: 250), control1: CGPoint(x: 370 + adjustment, y: 310), control2: CGPoint(x: 310 + adjustment, y: 310))
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.drawPath(using: .stroke)
        }
        
        imageView.image = image
    }
}

