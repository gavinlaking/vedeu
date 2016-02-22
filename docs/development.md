## Mutant Testing

    bundle exec mutant -r ./lib/vedeu -I lib -I test --require test_helper \
      --use minitest Vedeu

Not currently working as throws an exception:

    home/gavinlaking/.gem/ruby/2.3.0/bundler/gems/mutant-21875781db81/lib/mutant/integration/minitest.rb:55:in `expression_syntax': undefined method `cover_expression' for #<Class:0x005577b86385c8> (NoMethodError)

