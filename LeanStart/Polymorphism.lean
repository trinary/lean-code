structure PPoint (α : Type) where
  x : α
  y : α
deriving Repr

def natOrigin : PPoint Nat :=
  { x := Nat.zero, y := Nat.zero}

def replaceX (α : Type) (point : PPoint α) (newX : α) : PPoint α :=
  { point with x := newX}

#check replaceX

inductive Sign where
  | pos
  | neg

def posOrNegThree (s : Sign) : match s with | Sign.pos => Nat | Sign.neg => Int :=
  match s with
  | Sign.pos => (3 : Nat)
  | Sign.neg => (-3 : Int)


def length {α : Type} (xs : List α) : Nat :=
  match xs with
  | [] => Nat.zero
  | _ :: ys => Nat.succ (length ys)

#check List.head?

def fives : String × Int := { fst := "five", snd := 5 }

def eitherString : Type := String ⊕ String

/- exercises from https://lean-lang.org/functional_programming_in_lean/getting-to-know/polymorphism.html -/

/- Write a function to find the last entry in a list. It should return an Option. -/
def last {α : Type} (xs : List α): Option α :=
  match xs with
  | [] => Option.none
  | y :: [] => y
  | _ :: ys => last ys

#eval last [] (α := Nat)
#eval last [1,2,3]
#eval last [1]

/- Write a function that finds the first entry in a list that satisfies a given predicate-/

def List.findFirst? {α : Type} (xs : List α ) (predicate : α -> Bool) : Option α :=
  match xs with
  | [] => Option.none
  | y :: ys => if predicate y then y else findFirst? ys predicate

#eval [1,2,3].findFirst? (· % 2 == 0)

/- Write a function Prod.swap that swaps the two fields in a pair. -/
def Prod.swap {α β : Type} (pair : α × β) : β × α := {fst := pair.snd, snd := pair.fst }
#eval ("foo", 2).swap

/- Rewrite the PetName example to use a custom datatype -/
inductive PetName where
  | dogName : String → PetName
  | catName : String → PetName
deriving Repr

def animals : List PetName := [PetName.dogName "dog1", PetName.catName "cat1", PetName.dogName "dog2"]

def countDogs (pets : List PetName) : Nat :=
  match pets with
  | [] => 0
  | PetName.dogName _ :: morePets => 1 + countDogs morePets
  | PetName.catName _ :: morePets => countDogs morePets

#eval countDogs animals

#check List (Nat × Nat)

/- Write a function zip that combines two lists into a list of pairs. -/
def zip {α β : Type} (as : List α) (bs : List β ) : List (α × β) :=
  match as, bs with
  | [], _ => []
  | _, [] => []
  | a :: moreAs, b :: moreBs => (a, b) :: zip moreAs moreBs

#eval zip [1, 2, 3] ["one", "two", "three"]
#eval zip [2,1] ["two", "one", "three"]

/- Write a polymorphic function take that returns the first n entries in a list, where n is a Nat. -/
def take {α : Type} (num : Nat) (as : List α) : List α :=
  match as, num with
  | a :: as, Nat.succ s => a :: take s as
  | _, _ => []

#eval take 3 ["bolete", "oyster"]
#eval take 1 ["bolete", "oyster"]

/- Using the analogy between types and arithmetic, write a function that distributes products over sums.
😱 the fn type is α × (β ⊕ γ) → (α × β) ⊕ (α × γ)
α × β is a product type, where each value is an α and a β together
α ⊕ β is a sum type, a single value of either type α or type β
so we end up with *either* an α and β OR an α and γ as product elements in a sum. Makes sense!
I don't know how to express that the resulting type from (x.fst, x.snd) IS ALREADY the sum type we want though :(
having reasoned through it this seems axiomatic, how do I write it?
Just (x.fst, x.snd) doesn't infer the sum-of-products type we want -/

def distribute {α β γ : Type} (x : α × (β ⊕ γ)) : (α × β) ⊕ (α × γ) :=
  match x.snd with
  | Sum.inl b => Sum.inl (x.fst, b)
  | Sum.inr g => Sum.inr (x.fst, g)
/- I AM STARTING TO UNDERSTAND -/

/- Using the analogy between types and arithmetic, write a function that turns multiplication by two into a sum. -/
/- type: Bool × α → α ⊕ α -/
/- 😥 maybe similar issue to the previous exercise, I am not sure of the syntax I need to express this -/
def double { α : Type } (x : (Bool × α)) : (α ⊕ α) :=
  if x.fst then Sum.inl x.snd else Sum.inr x.snd

/- yessss -/
