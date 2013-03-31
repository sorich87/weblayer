# A sample Guardfile
# More info at https://github.com/guard/guard#readme
require 'capybara-webkit'

guard 'minitest' do
  watch(%r|^test/(.*)\/?(.*)_test\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/test_helper\.rb|)    { "test" }
  watch(%r|^app/controllers/(.*)\/?(.*)\.rb|) { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r|^app/helpers/(.*)\/?(.*)\.rb|)     { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r|^app/models/(.*)\/?(.*)\.rb|)      { |m| "test/models/#{m[1]}_test.rb" }
end

guard :konacha, spec_dir: 'test/javascripts', driver: :webkit do
  watch(%r{^app/assets/javascripts/(.*)\.js(\.coffee)?$}) { |m| "#{m[1]}_test.js" }
  watch(%r{^test/javascripts/.+_test(\.js|\.js\.coffee)$})
end
