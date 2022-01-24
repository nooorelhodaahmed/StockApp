//
//  LineColor.swift
//  LineChart
//
//  Created by Pandu on 11/24/19.
//

public struct LineColor {
    public var lineColor: UIColor = .white
    public var areaColor: UIColor = .white
    public var dotColor: UIColor = .white
    
    public init(lineColor: UIColor, areaColor: UIColor, dotColor: UIColor) {
        self.lineColor = lineColor
        self.areaColor = areaColor
        self.dotColor = dotColor
    }
}
