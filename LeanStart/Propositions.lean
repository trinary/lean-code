/- https://lean-lang.org/functional_programming_in_lean/props-proofs-indexing.html -/

def onePlusOneIsTwo : 1 + 1 = 2 := rfl

#check onePlusOneIsTwo
/- the type of onePlusOneIsTwo is 1 + 1 = 2. Not the value, the type. -/
/- the value is "reflexivity", which is a Prop constructor I think?-/
#check rfl
/- `∀ {α : Sort u} {a : α}, a = a` -/
/- For all α of Sort u, given a of type α, a...is true? Maybe? -/

/- def onePlusOneIsThree : 1 + 1 = 3 := rfl -/
/- this ^ doesn't compile. Probably because the expression of this def's type cannot construct a Prop?
  I think that's different than evaluating to true, as it isn't doing a == boolean check, it's a full expression of equality. -/

/- "This error message indicates that rfl can prove that two expressions are equal
    when both sides of the equality statement are already the same number." -/

/- When a proposition is proven, it is called a theorem -/

def OnePlusOneIsTwo : Prop := 1 + 1 = 2
theorem onePlusOneIsTwoTheorem : OnePlusOneIsTwo := rfl

theorem onePlusOneIsTwoTactic : 1 + 1 = 2 := by
  simp /- lol -/

theorem addAndAppend : 1 + 1 = 2 ∧ "Str".append "ing" = "String" := by simp
#check addAndAppend
-- #eval addAndAppend
/- can't eval a theorem, "invalid universe level" ok sure my bad -/

/- evidence for "A and B" is a pair that contains evidence for A and evidence for B -/
/- evidence for an "And" proposition is a constructor And.into, with type : A → B → A ∧ B -/
theorem addAndAppendWithAndConstrutor : 1 + 1 = 2 ∧ "Foo".append "bar" = "Foobar" := And.intro rfl rfl
/- simp just does that kind of easy evidence definition for us -/

/- Or has two constructors, since you either need to prove the first or the second prop -/
/- Or.inl meaning "Or intro left" and Or.inr meaning "Or intro right" -/
/- example: only one of these props in an OR is true, the left, so we construct using Or.inl -/
theorem addOrAppend : 1 + 1 = 2 ∨ "Foo".append "wrong" = "Foobar" := Or.inl rfl

/- Implication "if A then B" is represented in functions. A fn that takes evidence for A and produces evidence for B
   is a proof of "if A then B"-/

theorem andImpliesOr : A ∧ B → A ∨ B :=
  fun andEvidence =>
    match andEvidence with
    | And.intro a _ => Or.inl a

/- evidence as arguments -/
/- we can't prove that this fn is valid for various inputs, since we don't know the length of the input: -/
-- def third (xs : List α) : α := xs[2]

/- We can add an argument that provides evidence that the function will work: -/
def thirdWithEvidence (xs : List α) (ok : xs.length > 2) : α := xs[2]

/- we can then call it with a `by` argument to provide the evidence, in this case `simp` is the only thing needed -/
#eval thirdWithEvidence ["one", "two", "three"] (by simp)

/- exercises -/

/- Prove the following theorems using rfl: 2 + 3 = 5, 15 - 8 = 7, "Hello, ".append "world" = "Hello, world".
What happens if rfl is used to prove 5 < 18? Why?-/

theorem twoPlusThreeIsFive : 2 + 3 = 5 := rfl
theorem helloAppendWorld : "hello".append " world" = "hello world" := rfl
-- theorem rflLessThan : 5 < 18 := rfl /- I think this doesn't work because reflexivity works on either side of an equality, not a True value. Not 100% sure. -/

/- Prove the following theorems using by simp: -/
/- 2 + 3 = 5 -/
theorem twoPlusThreeBySimp : 2 + 3 = 5 := by simp

/- 15 - 8 = 7 -/
theorem fifteenMinusEightBySimp : 15 - 8 = 7 := by simp

/- "Hello, ".append "world" = "Hello, world" -/
theorem helloWorldBySimp : "hello ".append "world" = "hello world" := by simp

/- 5 < 18 -/
theorem lessThanEighteen : 5 < 18 := by simp
/- I don't really know the difference between this and the rflLessThan exercise. -/

/- Write a function that looks up the fifth entry in a list.
Pass the evidence that this lookup is safe as an argument to the function.-/

def fifthWithEvidence (xs : List α) (ok : xs.length > 4) : α := xs[4]

#eval fifthWithEvidence [1, 2, 3, 4, 5] (by simp)
