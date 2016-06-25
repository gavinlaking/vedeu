### Vedeu.esc

Provides access to various escape sequences defined by Vedeu.

#### Colour escape sequences
The examples below show two ways to use the escape sequences defined
by Vedeu.

- When a block is given, the background or foreground is reset back to
  the default background or foreground when the block exits.
- When a block is given, we can nest.
- When a block is not given, the escape sequence for the respective
  background or foreground is returned.

    ```ruby
    # Produces the `\e[31m` foreground escape sequence for 'red'.
    Vedeu.esc.red

    # Produces `\e[32mgrass\e[39m`; effectively rendering the word
    # 'grass' as green, and returning to the default terminal
    # foreground colour.
    Vedeu.esc.green { 'grass' }

    # Produces `\e[31mred \e32mgreen\e[39m\e[39m`; as nesting is
    # permitted with these directives.
    Vedeu.esc.red { 'red ' + Vedeu.esc.green { 'green' } }
    ```

- Valid named colours are:

    ```ruby
    | Foreground    | Code | Background       | Code |
    |---------------|------|------------------|------|
    | black         | 30   | on_black         | 40   |
    | red           | 31   | on_red           | 41   |
    | green         | 32   | on_green         | 42   |
    | yellow        | 33   | on_yellow        | 43   |
    | blue          | 34   | on_blue          | 44   |
    | magenta       | 35   | on_magenta       | 45   |
    | cyan          | 36   | on_cyan          | 46   |
    | light_grey    | 37   | on_light_grey    | 47   |
    | default       | 39   | on_default       | 49   |
    | dark_grey     | 90   | on_dark_grey     | 100  |
    | light_red     | 91   | on_light_red     | 101  |
    | light_green   | 92   | on_light_green   | 102  |
    | light_yellow  | 93   | on_light_yellow  | 103  |
    | light_blue    | 94   | on_light_blue    | 104  |
    | light_magenta | 95   | on_light_magenta | 105  |
    | light_cyan    | 96   | on_light_cyan    | 106  |
    | white         | 97   | on_white         | 107  |
    ```
