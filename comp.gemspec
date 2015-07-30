Gem::Specification.new do |s|
  s.name = 'comp'
  s.version = '1.0.0'
  s.summary = 'Functional composition with Procs and Methods in Ruby'
  s.description = <<-EOF
    A library to add functional composition between Procs and Methods in Ruby.
  EOF
  s.license = 'MIT'
  s.authors = ['Paul Mucur']
  s.email = 'mudge@mudge.name'
  s.homepage = 'https://github.com/mudge/comp'
  s.files = %w(README.md LICENSE) + Dir['lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_development_dependency('rspec', '~> 3.3')
end
