# frozen_string_literal: true

module Utils
  module Contextable
    extend ActiveSupport::Concern

    module ClassMethods
      def with_context *variables
        variables.each do |variable|
          define_method(variable) do
            context.fetch(variable)
          end
        end
      end
    end
  end
end
