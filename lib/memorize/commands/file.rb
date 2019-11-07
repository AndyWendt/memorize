# frozen_string_literal: true
require 'yaml'
require "tty-prompt"
require_relative '../command'

module Memorize
  module Commands
    class File < Memorize::Command
      def initialize(options, path)
        @options = options
        @path = path
      end

      def execute(input: $stdin, output: $stdout)
        prompt = TTY::Prompt.new
        # output.puts questions
        questions.each do |question|
          prompt.say("\n")
          answer = prompt.ask(question["question"], echo: true)
          # prompt.multiline("Description?")
          prompt.say("\n")
          prompt.say("=====Question=====")
          prompt.say(question["question"])
          prompt.say("\n")
          prompt.say("=====Answer=====")
          prompt.say(question["answer"])
          prompt.say("\n")
          prompt.say("=====Your Answer=====")
          prompt.say(answer)
          prompt.say("\n")
        end
      end

      private

      def questions
        YAML.load(::File.read("#{Dir.getwd}/storage/#{@path}.yml"))
      end
    end
  end
end
