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
  - centred (or centred!)
  - cursor
  - colour
  - delay
  - focus!
  - foreground
  - group
  - height
  - keys
  - line
  - name
  - style
  - use
  - width
  - x
  - y


#### Views

- render
  - views
    - view
  - view
    - colour
    - cursor
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
      - style
    - name
    - style
  - use


#### Menus

- menu
  - items
  - name


#### Miscellany

- defined
- focus
- height
- log
- resize
- width

