# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "GithubBlog"
  spec.version       = "0.1.0"
  spec.authors       = ["supgeek-rod"]
  spec.email         = ["supgeek.rod@gmail.com"]

  spec.summary       = "Github theme for jekyll"
  spec.homepage      = "https://github.com/supgeek-rod"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README|_config\.yml)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.2"
end
