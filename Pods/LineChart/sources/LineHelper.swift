//
//  LineHelper.swift
//  LineChart
//
//  Created by Pandu on 11/24/19.
//

public class LineHelper {
    public class func lightenUIColor(_ color: UIColor) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * 2, alpha: a)
    }
}
