## Vedeu API

Vedeu provides a simple DSL for the creation of terminal/console based
applications.

Below is a list of all the API methods. These can be accessed in your
application by including Vedeu in your class or module or by calling them directly.


### API 'include' example

Doing it this way will mean you can use any API method without the `Vedeu.` prefix.

```ruby
class SomeClassInYourApplication
  include Vedeu

  ...
```


### API direct example

Doing it this way means you need to use the `Vedeu.` prefix.

```ruby
class OtherClassInYourApplication
  ...

  def some_method
    Vedeu.some_api_method
  end

  ...
```

... TODO ...


### API DSL methods

Note: Nesting indicates where an API method is allowed/supposed to be used.

#### Events

- event
- trigger
- unevent


#### Input

- keypress
- keys
  - key
  - interface


#### Interfaces

- interface
  - background
  - border
  - cursor
  - colour
  - delay
  - focus!
  - foreground
  - geometry
    - centred (or centred!)
    - height
    - width
    - x
    - y
  - group
  - keys
  - line
  - name
  - style
  - use


#### Views

- render
  - views
    - view
  - view
    - colour
    - cursor
    - geometry
      - height
      - width
      - x
      - y
    - line
      - background
      - colour
      - foreground
      - stream
        - align
        - background
        - colour
        - foreground
        - style
        - text
        - width
      - text
      - style
    - name
    - style
  - use


#### Menus

- menu
  - items
  - name


#### Miscellany

- configure
- defined
- focus

- height
  Usage: Vedeu.height
  Returns the height (in lines) for the current terminal.

- log
- resize
  Usage: Vedeu.resize


- width
  Usage: Vedeu.width
  Returns the width (in characters) for the current terminal.

