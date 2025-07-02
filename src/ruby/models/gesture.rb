# The {Gesture} class is used for detecting some simple gesture based
# interactions from the player.
class Gesture
  # @!group Touch input

  # When no gesture has happened.
  NONE = 0
  # When the tap gesture was triggered.
  TAP = 1
  # When the doubletap gesture was triggered.
  DOUBLETAP = 2
  # When the hold gesture was triggered.
  HOLD = 4
  # When the drag gesture was triggered.
  DRAG = 8
  # When the swipe right gesture was triggered.
  SWIPE_RIGHT = 16
  # When the swipe left gesture was triggered.
  SWIPE_LEFT = 32
  # When the swipe up gesture was triggered.
  SWIPE_UP = 64
  # When the swipe down gesture was triggered.
  SWIPE_DOWN = 128
  # When the pinch in gesture was triggered.
  PINCH_IN = 256
  # When the pinch out gesture was triggered.
  PINCH_OUT = 512

  # @!endgroup
end
