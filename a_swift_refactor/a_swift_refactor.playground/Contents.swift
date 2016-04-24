// A Swift Refactor
//  PunGame = .Strong
// https://medium.com/the-traveled-ios-developers-guide/a-swift-refactor-831e9a8f18a#.d4mhvcdpg

import Cocoa

//Assume PlayerRound is a simple struct with a roundScore Int
//CongratsMessage is also a struct with a roundCongrats String
struct PlayerRound {
    var roundScore: Int?
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

if aRound != nil
{
    if aRound?.roundScore >= 5 && aRound?.roundScore <= 10
    {
        print("Score gets an A+")
        let iterationNum = [1,2,3]
        for i in 0...iterationNum.count
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
}