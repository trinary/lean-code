
/- a type that represents positive numbers, similar to Nat but having a base value of 1 instead of 0 -/
inductive Pos : Type where
 | one : Pos
 | succ : Pos → Pos

/- doesn't work well with literals tho -/
-- def seven : Pos := 7 /- fails -/

/- you need to use the constructors directly -/
def three : Pos := (Pos.succ (Pos.succ Pos.one))

/- compiler doesn't know that they can be added etc either -/
-- #eval three + three /- failed to synthesize instance HAdd Pos Pos-/

/- typeclasses, haskell style -/
class MyPlus (α : Type) where
  plus : α → α → α

/- typeclasses are types, can be used everywhere types can. -/
#check MyPlus /- The type of MyPlus is Type → Type. lets get weird! -/
/- It takes an α type as argument and results in a new type that describes the overload of Plus's operation for α -/

/- so wait can I apply it to something like a function? -/
def plussed := MyPlus Pos
#check plussed

/- it seems like I can. -/

/- overload properly for a specific type arg: -/
instance : MyPlus Nat where
  plus := Nat.add

/- let's do it for Pos -/
def Pos.plus : Pos → Pos → Pos
  | Pos.one, k => Pos.succ k
  | Pos.succ n, k => Pos.succ (n.plus k)

instance : MyPlus Pos where
  plus := Pos.plus

def six : Pos := MyPlus.plus three three

open MyPlus (plus) -- this makes it so we don't have to use the namespace
def nine : Pos := plus three six

/- define an instance of Add Pos to use + addition syntax -/

instance : Add Pos where
  add := Pos.plus

def twelve : Pos := nine + three -- yay

/- tostring stuff -/

-- a little silly, but it works
def posToString (atTop : Bool) (p : Pos) : String :=
  let paren s := if atTop then s else "(" ++ s ++ ")"
  match p with
  | Pos.one => "Pos.one"
  | Pos.succ n => paren s!"Pos.succ {posToString false n}"

-- instance : ToString Pos where
--   toString := posToString true

/- better -/
def Pos.toNat : Pos → Nat
  | Pos.one => 1
  | Pos.succ n => n.toNat + 1

instance : ToString Pos where
  toString x := toString (x.toNat)

#eval s!"{three}"

def Pos.mul : Pos → Pos → Pos
  | Pos.one, k => k
  | Pos.succ n, k => n.mul k + k

instance : Mul Pos where
  mul := Pos.mul

#eval three * six

instance : OfNat Pos (n + 1) where
  ofNat :=
    let rec natPlusOne : Nat → Pos
      | 0 => Pos.one
      | k + 1 => Pos.succ (natPlusOne k)
    natPlusOne n

def eight : Pos := 8

/- Exercises: define a datatype that represents only even numbers. Define Add, Mul, and ToString -/

inductive Even : Type where
  | two : Even
  | succ : Even → Even

def Even.add : Even → Even → Even
  | Even.two, k => Even.succ k
  | Even.succ n, k => Even.succ (n.add k)

instance : Add Even where
  add := Even.add

/- TODO: this isn't right yet. How do I restrict it to only evens? This is just pos. -/

-- Define an inductive type that represents an interesting subset of the HTTP methods, and a structure
-- that represents HTTP responses. Responses should have a ToString instance that makes it possible to
-- debug them. Use a type class to associate different IO actions with each HTTP method, and write a test
-- harness as an IO action that calls each method and prints the result.

/- TODO: ok relax lean book, this is a lot :( I'll get to it sometime. -/
