guard :minitest, all_after_pass: true,
                 focus_on_failed: true,
                 env: { 'NO_SIMPLECOV' => true } do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/(.+)\.rb}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb}) { 'test' }
  watch(%r{^lib/(.+)all\.rb})      { 'test' }
end

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
