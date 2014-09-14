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
  - centred
  - colour
  - cursor
  - delay
  - group
  - height
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
    - line
      - background
      - colour
      - foreground
      - stream
        - align
        - colour
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
- height
- log
- resize
- width

