"Hi ho, Io\n" print

Vehicle := Object clone
Vehicle print

// Vehicle is not a class. It's not a template
// used to create objects. It is an object, based
// on the Object prototype.

Vehicle description := "Something to take you places"
Vehicle print

// Objects have slotes. The collection of slots
// can be thought of as a hash. = can be used for
// assignment, if the slot doesn't exist, Io throws
// an exception.

Vehicle description = "Something to take you far away."

// Vehicle nonexsitingSlot = "This won't work."
// Exception: Slot nonexsitingSlot not found. Must define slot using := operator before updating.

Vehicle description print

Vehicle slotNames println

Vehicle type println
Object type println

// A type is an object, not a class


// ######### Objects, Prototypes and Inheritance #########
Car := Vehicle clone
Car type println
Car slotNames println
Car description println

// There's no description slot on Car, so Io
// forwards the description message to the prototype
// and finds the slot in Vehicle.

ferrari := Car clone
ferrari slotNames println
// There's no type slot! By convention,
// types in Io begin with uppercase letters.
// Now, when you invoke type slot, you'll get
// the type of your prototype. THis is how object
// model workds.
ferrari type println

// ferrari is identical to car, only it doesn't
// have a type slot; both are objects. This
// is how you use conventions, rather than a language,
// feature to distinguish between types and instances.


// ######### Methods #########
method("so you've come for an argument." println) print
method() type println

// Since a method is an object, we can assign it to a slot:
Car drive := method("Vroom" println)
Car drive
ferrari drive

ferrari getSlot("drive") print
// It will give parent's slot if the slot doesn't exist.
ferrari getSlot("type") println

ferrari proto println

Lobby print


// ######### Lists and Maps #########
toDos := list("find my car", "find Continuum Transfunctioner")
toDos println

toDos size println
toDos append("Find a present.")
toDos println

// list has convenience methods for math and dealing with
// the list as other data structures, such as stacks:
numList := list(1, 2, 3, 4)
numList average println
numList sum println
numList at(1) println
numList append(5) println
numList pop println
numList println
numList prepend(0)
numList println
list() isEmpty println

elvis := Map clone
elvis atPut("home", "Graceland")
elvis at("home") println
elvis atPut("style", "rock and roll")
elvis asObject println
elvis asList println
elvis keys println
elvis size println
