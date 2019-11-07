# frozen_string_literal: true
require 'yaml'
require_relative '../command'

module Memorize
  module Commands
    class File < Memorize::Command
      def initialize(options, path)
        @options = options
        @path = path
      end

      def execute(input: $stdin, output: $stdout)
        output.puts read
      end

      private

      def read
        YAML.load(::File.read("#{Dir.getwd}/storage/#{@path}.yml"))
      end
    end
  end
end
