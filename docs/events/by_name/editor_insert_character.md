### `:_editor_insert_character_`

This event attempts to insert the given character in the named
document at the current virtual cursor position.

Note: 'character' is a string.

    Vedeu.trigger(:_editor_insert_character_, name, character)
