// Understanding Collections Types in Swift — Part 3
// https://medium.com/swift-programming/understanding-collections-types-in-swift-part-3-making-your-own-classes-collections-aabbf186b801#.k4hsfgsua

import Cocoa

struct Person: Hashable, CustomStringConvertible {
    var firstName: String
    var lastName: String
    var email: String
    
    var hashValue: Int {
        get {
            return "first:\(firstName), last:\(lastName), email:\(email)".hashValue
        }
    }
    
    var description: String {
        get {
            return "name: \(firstName) \(lastName) email: \(email)"
        }
    }
}

// All objects that conform to Hashable require a global == implementation
// removing this will cause an error to show up on Person
func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

// Add custom printing

struct PeopleCollection: Hashable, CustomStringConvertible {
    var people: Set<Person> = []
    
    mutating func add(person: Person) {
        // [BET] - is the .contains call necessary? Nope
        //if !people.contains(person) {
            people.insert(person)
        //}
    }
    
    mutating func remove(person: Person) -> Person? {
        let removedPerson = people.remove(person)
        return removedPerson
    }
    
    func retrieveByFirstName(name: String) -> [Person]? {
        let foundPeople = people.filter {
            $0.firstName == name
        }
        return foundPeople
    }
    
    func retrieveByLastName(name: String) -> [Person]? {
        let foundPeople = people.filter {
            $0.lastName == name
        }
        
        return foundPeople
    }
    
    func retrieveSharedContacts(contacts: PeopleCollection) -> Set<Person>? {
        let commonContacts = self.people.intersect(contacts.people)
        return commonContacts
    }
    
    var count: Int {
        get {
            return people.count
        }
    }
    
    var hashValue: Int {
        get {
            return people.hashValue
        }
    }
    
    var description: String {
        get {
            var _description: String = ""
            for person in self.people {
                _description += "person: \(person) "
            }
            return _description
        }
    }
}

func ==(lhs: PeopleCollection, rhs: PeopleCollection) -> Bool {
    return lhs.hashValue == rhs.hashValue
}


// [BET] Use the new collection
let jack = Person(firstName: "Jack", lastName: "Jones", email: "jack_white@acme.com")
let lee = Person(firstName: "Lee", lastName: "Black", email: "lb@acme.com")
let roger = Person(firstName: "Roger", lastName: "Bland", email: "rb@xzy.com")
let mary = Person(firstName: "Mary", lastName: "Jones", email: "mw@xyz.com")

var peopleList = PeopleCollection()
peopleList.add(jack)
peopleList.add(lee)
peopleList.add(roger)
peopleList.add(mary)
peopleList.add(jack) // No error from trying to add Jack again
peopleList.count
print(peopleList)

let removeJack = peopleList.remove(jack)
print(peopleList)
peopleList.count
peopleList.add(removeJack!)

let theJones = peopleList.retrieveByLastName("Jones")
theJones?.count

var contactList = PeopleCollection()
contactList.add(Person(firstName: "Jack", lastName: "Jones", email: "jack_white@acme.com"))
contactList.add(Person(firstName: "Lee", lastName: "Black", email: "lb@acme.com"))
contactList.add(Person(firstName: "Robert", lastName: "Bland", email: "rb@xzy.com"))
contactList.add(Person(firstName: "Mickey", lastName: "Jones", email: "mw@xyz.com"))

let commonContacts = peopleList.retrieveSharedContacts(contactList)
commonContacts?.count
print(commonContacts!)

