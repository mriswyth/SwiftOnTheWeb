// A Swift Refactor
//  PunGame = .Strong
// https://medium.com/the-traveled-ios-developers-guide/a-swift-refactor-831e9a8f18a#.d4mhvcdpg

import Cocoa

//Assume PlayerRound is a simple struct with a roundScore Int
//CongratsMessage is also a struct with a roundCongrats String
struct PlayerRound {
    var roundScore: Int?
    
    init () {
        roundScore = 4
    }
}

struct CongratsMessage {
    var roundCongrats: String
    
    init() {
        roundCongrats = "Congrats"
    }
}

func randomCongrats() -> CongratsMessage {
    return CongratsMessage()
}

let aRound:PlayerRound? = PlayerRound()

if let playerScore = aRound?.roundScore where 5...10 ~= playerScore
{
    print("Score gets an A+")
    for _ in 1...3
    {
        print("Awesome, we are showing a victory message!!")
        let message = randomCongrats()
        switch message
        {
        case let message where message is String:
            print(message)
        case let message where message is CongratsMessage:
            print(message.roundCongrats)
        default:
            print("Uh oh")
        }
    }
}
