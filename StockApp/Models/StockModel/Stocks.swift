/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Stocks : Codable {
	let id : Int?
	let isDown : Bool?
	let isUp : Bool?
	let bid : Double?
	let difference : Double?
	let offer : Double?
	let price : Double?
	let volume : Double?
    var symbol : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case isDown = "isDown"
		case isUp = "isUp"
		case bid = "bid"
		case difference = "difference"
		case offer = "offer"
		case price = "price"
		case volume = "volume"
		case symbol = "symbol"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		isDown = try values.decodeIfPresent(Bool.self, forKey: .isDown)
		isUp = try values.decodeIfPresent(Bool.self, forKey: .isUp)
		bid = try values.decodeIfPresent(Double.self, forKey: .bid)
		difference = try values.decodeIfPresent(Double.self, forKey: .difference)
		offer = try values.decodeIfPresent(Double.self, forKey: .offer)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		volume = try values.decodeIfPresent(Double.self, forKey: .volume)
		symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
	}

}
