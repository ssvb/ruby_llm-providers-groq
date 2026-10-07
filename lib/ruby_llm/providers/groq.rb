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

        # rubocop:disable-next Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Style/MultipleComparison
        # replace 'output_text' with 'input_text'
        def sanitize_input_types!(node)
          case node
          when Hash
            node.each do |key, value|
              if (key == :type || key == 'type') && (value == :output_text || value == 'output_text')
                node[key] = value.is_a?(Symbol) ? :input_text : 'input_text'
              else
                sanitize_input_types!(value)
              end
            end
          when Array
            node.each { |element| sanitize_input_types!(element) }
          end
        end

        # Groq does not support the 'include' field
        def render_payload(...)
          payload = super
          sanitize_input_types!(payload[:input]) if payload[:input]
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
