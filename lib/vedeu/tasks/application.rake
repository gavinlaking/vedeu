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
