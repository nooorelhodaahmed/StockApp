/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct HandsShakeModel : Codable {
	let aesKey : String?
	let aesIV : String?
	let authorization : String?
	let lifeTime : String?
	let status : Status?

	enum CodingKeys: String, CodingKey {

		case aesKey = "aesKey"
		case aesIV = "aesIV"
		case authorization = "authorization"
		case lifeTime = "lifeTime"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aesKey = try values.decodeIfPresent(String.self, forKey: .aesKey)
		aesIV = try values.decodeIfPresent(String.self, forKey: .aesIV)
		authorization = try values.decodeIfPresent(String.self, forKey: .authorization)
		lifeTime = try values.decodeIfPresent(String.self, forKey: .lifeTime)
		status = try values.decodeIfPresent(Status.self, forKey: .status)
	}
}
