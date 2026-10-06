# frozen_string_literal: true

require 'ruby_llm'

module RubyLLM
  module Providers
    # Groq API integration.
    class Groq < Provider
      # Groq's Responses protocol.
      class Responses < Protocols::Responses
        def models_url
          'models'
        end

        # Groq does not support the 'include' field
        def render_payload(...)
          payload = super
          payload.delete(:include)
          payload
        end
      end

      protocol :responses, Responses

      def api_base
        @config.groq_api_base || 'https://api.groq.com/openai/v1'
      end

      def headers
        { 'Authorization' => "Bearer #{@config.groq_api_key}" }
      end

      class << self
        def configuration_options
          %i[groq_api_key groq_api_base]
        end

        def configuration_requirements
          %i[groq_api_key]
        end

        # Use this only when the provider has no model-listing endpoint.
        # def assume_models_exist?
        #   true
        # end
      end
    end
  end
end

RubyLLM::Provider.register :groq, RubyLLM::Providers::Groq,
                           models: File.expand_path('../../../models.json', __dir__)
