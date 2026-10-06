# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyLLM::Providers::Groq do
  subject(:provider) { described_class.new(config) }

  let(:config) do
    RubyLLM::Configuration.new.tap do |provider_config|
      provider_config.groq_api_key = 'test-key'
      provider_config.groq_api_base = 'https://example.test/v1'
    end
  end

  it 'is registered with RubyLLM' do
    expect(RubyLLM::Provider.resolve(:groq)).to eq(described_class)
  end

  it 'registers a default protocol' do
    expect(described_class.protocols).to include(responses: described_class::Responses)
  end

  it 'declares provider configuration' do
    expect(described_class.configuration_options).to eq(%i[groq_api_key groq_api_base])
    expect(described_class.configuration_requirements).to eq(%i[groq_api_key])
  end

  it 'uses configured API base and bearer token' do
    expect(provider.api_base).to eq('https://example.test/v1')
    expect(provider.headers).to eq('Authorization' => 'Bearer test-key')
  end
end
