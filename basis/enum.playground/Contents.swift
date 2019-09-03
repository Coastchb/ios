struct PlayingCard {
    var suit : Suit
    var rank : Rank
    
    enum Suit : String, CustomStringConvertible {
        var description: String {
            return self.rawValue
        }
        case spades = "black heart"
        case hearts = "red heart"
        case clubs = "black flower"
        case diamonds = "red square"
        
        static var all = [Suit.spades, .hearts, .clubs, .diamonds]
    }
    
    enum Rank : CustomStringConvertible {
        case Ace
        case Face(String)
        case Numeric(Int)
        
        var description: String {
            switch self {
            case .Ace: return "1"
            case .Face(let str): return str
            case .Numeric(let i): return String(i)
            default: return ""
            }
        }
        static var all : [Rank] {
            var allRanks = [Rank]()
            allRanks.append(.Ace)
            for i in 2...10 {
                allRanks.append(.Numeric(i))
            }
            allRanks += [.Face("J"), .Face("Q"), .Face("K")]
            return allRanks
        }
    }
}

struct PlayingCardDeck {
    var allcards = [PlayingCard]()
    init() {
        for s in PlayingCard.Suit.all {
            for r in PlayingCard.Rank.all {
                allcards.append(PlayingCard(suit: s, rank: r))
            }
        }
    }
}

let s = PlayingCard.Suit.hearts
print(s)
let r = PlayingCard.Rank.Face("J")
print(r)
//print(s == "red heart")
