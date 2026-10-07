# ruby_llm-providers-groq

RubyLLM provider gem for [Groq](https://groq.com) support.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_llm-providers-groq', require: 'ruby_llm/providers/groq'
```

Then configure the provider:

```ruby
require 'ruby_llm/providers/groq'

RubyLLM.configure do |config|
  config.groq_api_key = ENV['GROQ_API_KEY']
end
```

## Usage

An example of automatically picking the first chat-capable model:

```ruby
model = RubyLLM.models.by_provider(:groq).chat_models.first
chat = RubyLLM.chat(provider: :groq, model: model.id)
response = chat.ask('Hello')
puts "The selected chat model '#{model.name}' replied:"
puts response.content
```

When using Enterprise models, add an extra `assume_model_exists: true` argument (as they are for some reason not listed in the models registry):

```ruby
chat = RubyLLM.chat(provider: :groq, model: 'llama-3.3-70b-versatile',
                    assume_model_exists: true)
```

## Development

The generator installs the bundle and creates an ignored `.env`. Edit the generated `op read` reference so it points to your 1Password credential. If you do not use the 1Password CLI, replace the expression with the provider key.

```sh
bundle exec rake models
bundle exec rake
```

`rake models` calls only Groq's model-listing endpoint and writes `models.json` at the gem root. RubyLLM loads that catalog as a fallback when this provider is registered, so applications do not need to combine registry files. The main RubyLLM registry always wins when both catalogs carry the same model. If the API uses a different path, change `models_url` in `lib/ruby_llm/providers/groq.rb`.

Run `rake models` from this provider gem when you want to update its packaged catalog. `RubyLLM.models.refresh` updates the application's main registry and does not refresh provider gem catalogs.

The suite always runs the provider integration specs. The first local run calls the API and records VCR cassettes; CI only replays committed cassettes. A failing example deletes its cassette so the next local run tests the live API again.

After refreshing the catalog, add real model IDs to `spec/support/models.rb`. Keep only the operation matrices the provider supports. The portable contract specs are adapted from [RubyLLM's live specs](https://github.com/crmne/ruby_llm/tree/main/spec/ruby_llm); use those as the reference when your provider needs coverage for another feature or dialect.
