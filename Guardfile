guard :rubocop do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :minitest, all_after_pass: true,
                 focus_on_failed: true,
                 env: { 'NO_SIMPLECOV' => true } do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/(.+)\.rb}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb}) { 'test' }
  watch(%r{^lib/(.+)all\.rb})      { 'test' }
end
