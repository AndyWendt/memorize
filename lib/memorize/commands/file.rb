# frozen_string_literal: true

require_relative '../command'

module Memorize
  module Commands
    class File < Memorize::Command
      def initialize(options, path)
        @options = options
        @path = path
      end

      def execute(input: $stdin, output: $stdout)
        # Command logic goes here ...
        output.puts @path
      end
    end
  end
end
