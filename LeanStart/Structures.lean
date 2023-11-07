structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }

#eval origin

structure RectangularPrism where
  h : Float
  w : Float
  d : Float
deriving Repr

def RectangularPrism.volume (rect : RectangularPrism) : Float :=
  rect.h * rect.w * rect.d

def unitRect : RectangularPrism := { h := 1.0, w := 1.0, d := 1.0 }

structure Segment where
  p1 : Point
  p2 : Point
deriving Repr

def line : Segment := { p1 := Point.mk 0.0 1.0, p2 := Point.mk 1.0 0.0}
