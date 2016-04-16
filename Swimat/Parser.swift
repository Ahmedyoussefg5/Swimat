import Foundation

extension SwiftParser {
	
	func isNextChar(char: Character) -> Bool {
		let next = strIndex.successor()
		if next < string.endIndex {
			return string[next] == char
		} else {
			return false
		}
	}
	
	func isNextString(string: String) -> Bool {
		return isNextString(strIndex, word: string)
	}
	
	func isNextString(start: String.Index, word: String) -> Bool {
		return string.substringFromIndex(start).hasPrefix(word)
	}
	
	func spaceWith(word: String) -> String.Index {
		retString.spaceWith(word)
		return string.nextNonSpaceIndex(strIndex.advancedBy(word.count))
	}
	
	func spaceWithArray(list: [String]) -> String.Index? {
		for word in list {
			if isNextString(word) {
				return spaceWith(word)
			}
		}
		return nil
	}
	
	func trimWithIndent() {
		if let last = retString.lastChar {
			if last.isSpace() {
				retString = retString.trim()
			}
		}
		if retString.lastChar == "\n" {
			addIndent()
		}
	}
	
	func addIndent() {
		retString += String(count: indent + tempIndent, repeatedValue: INDENT_CHAR)
	}
	
	func append(string: String) -> String.Index {
		retString += string
		strIndex = strIndex.advancedBy(string.count)
		return strIndex
	}
	
	func append(char: Character) -> String.Index {
		retString.append(char)
		strIndex = strIndex.successor()
		return strIndex
	}
	
	func addToNext(start: String.Index, stopWord: String) -> String.Index {
		var index = start
		while index < string.endIndex {
			if isNextString(index, word: stopWord) {
				break
			}
			index = index.successor()
		}
		retString += string[start ..< index]
		return index
	}
	
	func addToNext(start: String.Index, stopChar: Character) -> String.Index {
		var index = start
		while index < string.endIndex {
			if string[index] == stopChar {
				break
			}
			index = index.successor()
		}
		retString += string[start ..< index]
		return index
	}
}