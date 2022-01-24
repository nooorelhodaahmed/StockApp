//
//  LineChartProtocol.swift
//  LineChart
//
//  Created by Pandu on 11/24/19.
//

public protocol LineChartDelegate {
    func didSelectDotData(_ x: Int, yValues: [Double])
    func didSelectDotPoint(_ pos: CGPoint)
}
