# frozen_string_literal: true

module Utils
  module Callable
    module ClassMethods
      def call(*args, &block)
        new(*args, &block).call
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def call
      self
    end
  end
end
