
/- some nonsense scratch pad code, mostly from https://lean-lang.org/functional_programming_in_lean/getting-to-know/conveniences.html -/

def fromOption (default : α) : Option α → α
  | none => default
  | some x => x

def unzip : List (α × β) → List α × List β
 | [] => ([], [])
 | (x, y) :: xys =>
   (x :: (unzip xys).fst, y :: (unzip xys).snd)

/- in the impl above we call `unzip xys` twice, taking the full amount of runtime for each invocation -/
/- use a "let" stmt to memoize a single invocation per recursive match arm -/
def unzip2 : List (α × β) → List α × List β
 | [] => ([], [])
 | (x, y) :: xys =>
    let unzipped := unzip xys
    (x :: (unzipped).fst, y :: (unzipped).snd)

/- function literal syntax -/

#check fun (x : Int) => x + 1
#check λ (y : Nat) => y + 4 /- book says λ isnt used often, prefer `fun`. I like the symbols though :D -/

#check fun
  | 0 => none
  | n + 1 => some n

/- cuter syntax for anon functions -/
#check (·, ·) /- taxes 2 args, returns arg1 × arg2 using parens product syntax -/
#eval (·, ·) 1 2

/- define things in a type's namespace -/
def Nat.double (x : Nat) : Nat := x * 2

/- interpolation -/
#eval s!"foo bar {Nat.double 12}"
