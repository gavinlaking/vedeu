Given(/^the interface "(.*?)" is defined$/) do |interface|
  Vedeu::Interface.create({ name: interface, klass: Vedeu::DummyInterface, options: {} })
end

Given(/^the command "(.*?)" is defined$/) do |command|
  Vedeu::Command.create({ name: command, klass: Vedeu::DummyCommand, options: { keyword: command } })
end

When(/^the input "(.*?)" is entered$/) do |input|
  pending
end
