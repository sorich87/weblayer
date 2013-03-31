Konacha.configure do |config|
  config.spec_dir     = "test/javascripts"
  config.spec_matcher = /_spec\.|_test\./
  config.driver       = :webkit
  config.stylesheets  = %w(application)
end if defined?(Konacha)
