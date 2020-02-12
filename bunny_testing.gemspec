require_relative "lib/bunny/testing/version"

Gem::Specification.new do |spec|
  spec.name = "bunny_testing"
  spec.version = Bunny::Testing::VERSION
  spec.authors = ["Vitaly Shlyaga"]
  spec.email = ["vitaly@shlyaga.ru"]

  spec.summary = "Use bunny gem in your tests without running RabbitMQ"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage = "https://github.com/storkvist/bunny_testing"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.add_runtime_dependency "bunny", "~> 2.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(\.github|test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
end
