# frozen_string_literal: true

require_relative "lib/proptypes/version"

Gem::Specification.new do |spec|
  spec.name = "proptypes-rb"
  spec.version = Proptypes::VERSION
  spec.authors = ["Guilherme Andrade"]
  spec.email = ["guilherme.andrade.ao@gmail.com"]

  spec.summary = "A simple set of types for validation of ruby objects."
  spec.description = "A simple set of types for validation of ruby objects."
  spec.homepage = "https://github.com/guilherme-andrade/proptypes"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/guilherme-andrade/proptypes"
  spec.metadata["changelog_uri"] = "https://github.com/guilherme-andrade/proptypes"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "dry-types", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
