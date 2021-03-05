require File.expand_path('lib/typed_parameter/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'typed_parameter'
  spec.version               = TypedParameter::VERSION
  spec.authors               = ['Minwoo Jo']
  spec.email                 = ['tranquilthink@example.com']
  spec.summary               = 'Typed Paramter For Rails'
  spec.description           = 'Create typed parameter class using strong paramter in rails'
  spec.homepage              = 'https://github.com/tranquilthink/typed_parameter'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 3.0.0'

  # Dependencies
  spec.add_dependency 'rails', '~> 6.1'

  # Test Dependencies
  spec.add_development_dependency 'rspec'
end
