# frozen_string_literal: true

if ENV['RUBOCOP'].to_i == 1
  guard :rubocop do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end

guard :minitest, all_after_pass: true,
                 focus_on_failed: true do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/(.+)\.rb})         { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb}) { 'test' }
  watch(%r{^lib/(.+)all\.rb})      { 'test' }
end
