/- https://lean-lang.org/functional_programming_in_lean/type-classes/polymorphism.html -/
import «LeanStart».Polymorphism

#check (IO.println)
#check @IO.println -- "inst" in the type output is the instance itself

def List.sum [Add α] [OfNat α 0] : List α -> α
  | [] => 0
  | x :: xs => x + xs.sum

-- [] : specifications of required instances in square brackets are "instance implicits"
-- for ordinary implicit args ({} args I think?) lean finds a single arg value that satisfies the type checker
-- instance implicits have a built-in table of instance values. I don't yet know what this table is or how to get at it.

-- recall the PPoint polymorphic type (in Polymorphism.lean)
-- it takes a type arg α, so defining Add for PPoint α requires that Add be defined for α
-- we can add the instance implicit value and resolve addition:

instance [Add α] : Add (PPoint α ) where
  add p1 p2 := {x := p1.x + p2.x, y := p1.y + p2.y }

-- the [Add α] instance implicit causes lean to search for an Add instance of α

#check @OfNat.ofNat

/- skipping ahead a little to Arrays and Indexing https://lean-lang.org/functional_programming_in_lean/type-classes/indexing.html -/

structure NonEmptyList (α : Type) : Type where
  head : α
  tail : List α

def idahoSpiders : NonEmptyList String := {
  head := "Banded Garden Spider",
  tail := [
    "Long-legged Sac Spider",
    "Wolf Spider",
    "Hobo Spider",
    "Cat-faced Spider" -- 😺
  ]
}

def NonEmptyList.get? : NonEmptyList α -> Nat -> Option α
  | xs, 0 => some xs.head
  | xs, n + 1 => xs.tail.get? n

#eval idahoSpiders.get? 0
#eval idahoSpiders.get? 2
#eval idahoSpiders.get? 5

/- Here the book starts talking about `abbrev` as a keyword and introduces the symbol `NonEmptyList.inBounds`-/
/- inBounds appears to be a symbol used in the abbrev statement, but it's not clear what `abbrev` is. -/

/- "This function returns a proposition that might be true or false." ok-/
abbrev NonEmptyList.inBounds (xs : NonEmptyList α) (i : Nat) : Prop :=
  i ≤ xs.tail.length

theorem atLeastThreeSpiders : idahoSpiders.inBounds 2 := by simp -- "simp made no progress" this doesnt work? :(
