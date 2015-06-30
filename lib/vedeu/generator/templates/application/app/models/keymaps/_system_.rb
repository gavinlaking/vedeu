Vedeu.keymap('_system_') do
  # see http://www.rubydoc.info/gems/vedeu/Vedeu/DSL/Keymap
  key('e')        { Vedeu.trigger(:_exit_) }
  key(:esc)       { Vedeu.trigger(:_mode_switch_) }
  key(:shift_tab) { Vedeu.trigger(:_focus_previous_) }
  key(:tab)       { Vedeu.trigger(:_focus_next_) }
end
