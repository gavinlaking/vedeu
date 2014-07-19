require 'simplecov'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/hell'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end unless ENV['no_simplecov']

Minitest.after_run do
  print [27.chr, '[', '?25h'].join # show cursor
end

# commented out by default (makes tests slower)
# require 'minitest/reporters'
# Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
  # Minitest::Reporters::SpecReporter.new
# )

# trace method execution with local variables
# my_event = 'call'
# my_class = /^Vedeu/
# set_trace_func proc { |event, file, line, id, binding, classname|
#   if event == my_event && classname.to_s.match(my_class)
#     printf("\e[38;5;#{rand(22..231)}m%s %s #%s\e[38;2;39m\n", event, classname, id)
#     binding.eval('local_variables').each do |var|
#       print("#{var.to_s} = #{binding.local_variable_get(var).inspect}\n")
#     end
#   end
# }
