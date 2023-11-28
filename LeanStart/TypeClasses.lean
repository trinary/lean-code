
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
