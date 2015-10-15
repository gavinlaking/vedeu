# @title Vedeu Document Events

## Document Events

Note: 'name' is a Symbol unless mentioned otherwise.

### `:\_editor_execute\_`

    Vedeu.trigger(:_editor_execute_, name)

### `:\_editor_delete_character\_`
This event attempts to delete the character in the named
document at the current virtual cursor position.

    Vedeu.trigger(:_editor_delete_character_, name)

### `:\_editor_delete_line\_`
This event attempts to delete the line in the named document
at the current virtual cursor position.

    Vedeu.trigger(:_editor_delete_line_, name)

### `:\_editor_down\_`
This event attempts to move the virtual cursor down by one
line in the named document.

    Vedeu.trigger(:_editor_down_, name)

### `:\_editor_insert_character\_`
This event attempts to insert the given character in the named
document at the current virtual cursor position.

Note: 'character' is a string.

    Vedeu.trigger(:_editor_insert_character_, name, character)

### `:\_editor_insert_line\_`
This event attempts to insert a new line in the named document
at the current virtual cursor position.

    Vedeu.trigger(:_editor_insert_line_, name)

### `:\_editor_left\_`
This event attempts to move the virtual cursor left by one
character in the named document.

    Vedeu.trigger(:_editor_left_, name)

### `:\_editor_right\_`
This event attempts to move the virtual cursor right by one
character in the named document.

    Vedeu.trigger(:_editor_right_, name)

### `:\_editor_up\_`
This event attempts to move the virtual cursor up by one line
in the named document.

    Vedeu.trigger(:_editor_up_, name)
