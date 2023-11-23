
def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout

  stdout.putStrLn "oh no, the real world exists. Tell me your favorite thing about the real world."
  let input ← stdin.getLine
  let trimmedInput := input.dropRightWhile Char.isWhitespace

  stdout.putStrLn s!"Hmm. {trimmedInput} is ok I guess."

def nTimes (action : IO Unit) : Nat -> IO Unit
  | 0 => pure ()
  | n + 1 => do
    action
    nTimes action n
