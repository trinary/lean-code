
def onePlusOneIsTwo : 1 + 1 = 2 := rfl

#check onePlusOneIsTwo
/- the type of onePlusOneIsTwo is 1 + 1 = 2. Not the value, the type. -/
/- the value is "reflexivity", which is a Prop constructor I think?-/
#check rfl
/- ∀ {α : Sort u} {a : α}, a = a -/
/- For all α of Sort u, given a of type α, a...is true? Maybe? -/
def onePlusOneIsThree : 1 + 1 = 3 := rfl
/- this doesn't compile. Probably because the expression of this def's type cannot construct a Prop?
  I think that's different than evaluating to true, as it isn't doing a == boolean check, it's a full expression of equality. -/
