/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct StockDetailModel : Codable {
	let isDown : Bool?
	let isUp : Bool?
	let bid : Double?
	let channge : Double?
	let count : Double?
	let difference : Double?
	let offer : Double?
	let highest : Double?
	let lowest : Double?
	let maximum : Double?
	let minimum : Double?
	let price : Double?
	let volume : Double?
	let symbol : String?
	let graphicData : [GraphicData]?
	let status : Status?

	enum CodingKeys: String, CodingKey {

		case isDown = "isDown"
		case isUp = "isUp"
		case bid = "bid"
		case channge = "channge"
		case count = "count"
		case difference = "difference"
		case offer = "offer"
		case highest = "highest"
		case lowest = "lowest"
		case maximum = "maximum"
		case minimum = "minimum"
		case price = "price"
		case volume = "volume"
		case symbol = "symbol"
		case graphicData = "graphicData"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		isDown = try values.decodeIfPresent(Bool.self, forKey: .isDown)
		isUp = try values.decodeIfPresent(Bool.self, forKey: .isUp)
		bid = try values.decodeIfPresent(Double.self, forKey: .bid)
		channge = try values.decodeIfPresent(Double.self, forKey: .channge)
		count = try values.decodeIfPresent(Double.self, forKey: .count)
		difference = try values.decodeIfPresent(Double.self, forKey: .difference)
		offer = try values.decodeIfPresent(Double.self, forKey: .offer)
		highest = try values.decodeIfPresent(Double.self, forKey: .highest)
		lowest = try values.decodeIfPresent(Double.self, forKey: .lowest)
		maximum = try values.decodeIfPresent(Double.self, forKey: .maximum)
		minimum = try values.decodeIfPresent(Double.self, forKey: .minimum)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		volume = try values.decodeIfPresent(Double.self, forKey: .volume)
		symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
		graphicData = try values.decodeIfPresent([GraphicData].self, forKey: .graphicData)
		status = try values.decodeIfPresent(Status.self, forKey: .status)
	}

}
