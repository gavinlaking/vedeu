desc 'Create a skeleton Vedeu client application.'
task :new do
  app_name = ARGV[0]

  if app_name
    Vedeu::Generator::Application.generate(app_name)

  else
    print Vedeu::Esc.red { 'Error: ' }
    print 'You did not specify a name for the new application.'

  end
end

# 'Specify the interface name lowercase snakecase; e.g. main_interface'
desc 'Create a new interface within the client application.'
task :view do
  view_name = ARGV[0]

  if view_name
    Vedeu::Generator::View.generate(view_name)

  else
    print Vedeu::Esc.red { 'Error: ' }
    print 'You did not specify a name for the name view.'

  end
end
