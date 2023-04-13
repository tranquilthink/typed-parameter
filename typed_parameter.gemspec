require File.expand_path('lib/typed_parameter/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'typed-parameter'
  spec.version               = TypedParameter::VERSION
  spec.authors               = ['Minwoo Jo']
  spec.email                 = ['tranquilthink@gmail.com']
  spec.summary               = 'Typed Paramter For Rails'
  spec.description           = 'Create typed parameter class using strong paramter in rails'
  spec.homepage              = 'https://github.com/tranquilthink/typed-parameter'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.7.0'

  # spec.metadata['allowed_push_host'] = "https://github.com/tranquilthink/typed-parameter"
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/tranquilthink/typed-parameter'
  spec.metadata['changelog_uri'] = 'https://github.com/tranquilthink/typed-parameter/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Dependencies
  spec.add_dependency 'rails'

  # Test Dependencies
  spec.add_development_dependency 'rspec'
end
