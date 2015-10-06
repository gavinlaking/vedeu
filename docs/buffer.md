# @title Vedeu Buffers
# Vedeu Buffers

Each interface has an associated buffer, referenced by name. The
buffer has three states; 'back', 'front' and 'previous'.

- 'back': New view data is added to the 'back' buffer. It will be
  shown next time an interface or view is refreshed; by being moved to
  the 'front' buffer.
- 'front': Current view data belongs on the 'front' buffer. It will be
  shown every time the interface is refreshed unless new view data has
  been added to the 'back' buffer (see 'back').
- 'previous': Old view data resides on the 'previous' buffer. When new
  view data has been added to the back buffer, upon the next refresh,
  the current 'front' buffer data is moved to the 'previous' buffer,
  and the new 'back' data is added to the 'front' buffer.

Try to think of the above process as a conveyor belt of data. You will
only see 'front' data in the terminal.

    1) new -> 'back'
    2) refresh happens
    3) 'back' is copied to 'front'
    4) 'front' is displayed, but also copied to 'previous'

- Buffers can be refreshed independently. If the buffer for an
  interface is currently hidden, it will still refresh, you just won't
  see it. When the interface is visible again, you will see whatever
  the latest buffer data is for that interface.
