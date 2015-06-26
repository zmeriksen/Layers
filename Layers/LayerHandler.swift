//
//  LayerHandler.swift
//  Layers
//
//  Created by Zach Eriksen on 6/26/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import Foundation
import UIKit

class LayerHandler : NSObject{
    var layers : [Layer] = [] {
        didSet{
            layerHeight = screenHeight/CGFloat(layers.count)
            println(layerHeight!)
            var y : CGFloat = 0
            for layer in layers{
                layer.frame = CGRectMake(layer.frame.origin.x, y, layer.frame.width, layerHeight!)
                layer.updateLabel()
                layer.layerHeight = layerHeight
                y += layerHeight!
            }
        }
    }
    var y  : CGFloat = 0
    var tag = 0
    var layerHeight : CGFloat?
    
    override init(){
        layerHeight = screenHeight
    }
    
    func layerPressed(sender : AnyObject){
        var tag = sender.tag
        for layer in layers{
            if tag == 0{
                tag = -1
                 layer.animateBackToOriginalPosition()
            }else if tag == -1{
                layer.animateBackToOriginalPosition()
            }else if layer.tag == tag{
                layer.animateToMaximizedPosition()
            }else if layer.tag > tag{
                layer.animateBackToOriginalPosition()
            }else {
                layer.animateToMinimizedPosition()
            }
        }
    }
    
    func addLayer(color : UIColor, title : String) {
        let layer = Layer(y: y, color: color, title: title, tag: tag++, layerHeight : layerHeight!)
        y += layerHeight!
        let button = UIButton(frame: CGRectMake(0, 0, screenWidth, layerHeight!))
        button.addTarget(self, action: "layerPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        button.tag = layer.tag
        layer.addSubview(button)
        layer.sendSubviewToBack(button)
        layers.append(layer)
    }
    
    func layerWithTitle(title : String) -> Layer? {
        for l in layers {
            if l.label?.text == title {
                return l
            }
        }
        return nil
    }
}