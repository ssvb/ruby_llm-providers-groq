# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'ruby_llm-providers-groq'
  spec.version = '2.0.0.pre.1'
  spec.authors = ['Siarhiej Siamaška']
  spec.email = ['siarhei.siamashka@gmail.com']

  spec.summary = 'RubyLLM provider for Groq.'
  spec.description = 'Adds Groq provider support to RubyLLM.'
  spec.homepage = 'https://github.com/ssvb/ruby_llm-providers-groq'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.3'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.glob('{lib,spec}/**/*') +
               Dir.glob('.github/workflows/*.yml') +
               Dir.glob('models.json') +
               %w[.flayignore .overcommit.yml .rspec .rubocop.yml Archspec.rb LICENSE README.md]
  spec.require_paths = ['lib']

  spec.add_dependency 'ruby_llm', '~> 2.0', '>= 2.0.0'
end
