//
//  drawShapehandler.swift
//  DrawExample
//
//  Created by Nitesh Kant on 02/06/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import UIKit

class drawShapehandler: NSObject {

    func drawItems(itemList : Array<String>,onView:UITableViewCell)  {
       
        if itemList.count == 1{
             var xpos : CGFloat = 0
            xpos = (UIScreen.main.bounds.size.width / 2) - 30
            drawOvalAndRelationStuf(withXPosition: Float(xpos), andText: itemList[0], onView: onView)
            
        }else if itemList.count == 2{
            var xpos1 : CGFloat = 0
            var xpos2 : CGFloat = 0
            xpos1 = (UIScreen.main.bounds.size.width / 2) + 100
            xpos2 = (UIScreen.main.bounds.size.width / 2) - 100
            
            drawOvalAndRelationStuf(withXPosition: Float(xpos1), andText: itemList[0], onView: onView)
            
            drawOvalAndRelationStuf(withXPosition: Float (xpos2), andText: itemList[1], onView: onView)
        }
        else if itemList.count == 3{
            var xpos1 : CGFloat = 0
            var xpos2 : CGFloat = 0
            var xpos3 : CGFloat = 0
            xpos1 = (UIScreen.main.bounds.origin.x) + 20
            xpos2 = (UIScreen.main.bounds.size.width / 2) - 40
            xpos3 = (UIScreen.main.bounds.size.width)  - 80
            
            drawOvalAndRelationStuf(withXPosition: Float(xpos1), andText: itemList[0], onView: onView)
            
            drawOvalAndRelationStuf(withXPosition: Float (xpos2), andText: itemList[1], onView: onView)
            
            drawOvalAndRelationStuf(withXPosition: Float (xpos3), andText: itemList[2], onView: onView)
            
        }
        else {
            
            var xpos1 : CGFloat = 0
            var xpos2 : CGFloat = 0
            var xpos3 : CGFloat = 0
            var xpos4 : CGFloat = 0
            
            xpos1 = (UIScreen.main.bounds.origin.x + 20)
            
            xpos2 = xpos1 + 100
            xpos3 = xpos2 + 100
            xpos4 = xpos3 + 100
            
            
            drawOvalAndRelationStuf(withXPosition: Float(xpos1), andText: itemList[0], onView: onView)
            
            drawOvalAndRelationStuf(withXPosition: Float (xpos2), andText: itemList[1], onView: onView)
            
            drawOvalAndRelationStuf(withXPosition: Float (xpos3), andText: itemList[2], onView: onView)
            
            drawOvalAndRelationStuf(withXPosition: Float (xpos4), andText: itemList[3], onView: onView)
            
        }
    }
    
    func drawOvalAndRelationStuf(withXPosition:Float,andText:String,onView:UITableViewCell)  {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let color2 = UIColor(red: 0.019, green: 0.374, blue: 0.127, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 5
        let shadow2 = NSShadow()
        shadow2.shadowColor = UIColor.white
        shadow2.shadowOffset = CGSize(width: 3, height: 3)
        shadow2.shadowBlurRadius = 5
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: Int(withXPosition), y: 35, width: 50 , height: 50))
        UIColor.gray.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.lineCapStyle = .round
        ovalPath.lineJoinStyle = .bevel
        ovalPath.stroke()
        
        
        //// Rectangle Drawing
        let rectangleRect = CGRect(x: Int(withXPosition - 5), y: 90 , width: 60, height: 16)
        let rectanglePath = UIBezierPath(rect: rectangleRect)
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        color2.setFill()
        rectanglePath.fill()
        
        
        
        ////// Rectangle Inner Shadow
        context.saveGState()
        context.clip(to: rectanglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((shadow2.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangleOpaqueShadow = (shadow2.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: shadow2.shadowOffset, blur: shadow2.shadowBlurRadius, color: rectangleOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        rectangleOpaqueShadow.setFill()
        rectanglePath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        context.restoreGState()
        
        UIColor.gray.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()
        let rectangleStyle = NSMutableParagraphStyle()
        rectangleStyle.alignment = .center
        let rectangleFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 12)!, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: rectangleStyle]
        
        "\(andText)\n".draw(in: rectangleRect, withAttributes: rectangleFontAttributes)
        
        self.drawLineFromPoint(start: CGPoint.init(x: Int(withXPosition + 25), y: 106) , toPoint: CGPoint.init(x: Int(withXPosition + 25), y: 150), ofColor: UIColor.black, inView: onView)
    }
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UITableViewCell) {
        
        //design the path
        let bottomPath = UIBezierPath()
        bottomPath.move(to: start)
        bottomPath.addLine(to: end)
        bottomPath.lineWidth = 0.5
        
        let topPath = UIBezierPath()
        topPath.move(to: CGPoint.init(x: start.x , y: 35))
        topPath.addLine(to: CGPoint.init(x: end.x , y: 0))
        topPath.lineWidth = 0.5
        
        
        if view is GrandParentTableViewCell {
            bottomPath.stroke()
            bottomPath.fill()
        }else if view is ParentTableViewCell{
            bottomPath.stroke()
            bottomPath.fill()
            topPath.stroke()
            topPath.fill()
        }else if view is MeTableViewCell{
            bottomPath.stroke()
            bottomPath.fill()
            topPath.stroke()
            topPath.fill()
        }else{
            topPath.stroke()
            topPath.fill()
        }

    }

}
