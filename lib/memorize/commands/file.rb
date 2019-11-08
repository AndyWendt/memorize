# frozen_string_literal: true
require 'yaml'
require 'tty-markdown'
require 'tty-prompt'
require_relative '../command'

module Memorize
  module Commands
    class File < Memorize::Command
      def initialize(options, path)
        @options = options
        @path = path
        @prompt = TTY::Prompt.new
      end

      def execute(input: $stdin, output: $stdout)
        @output = output
        question_run(questions)
      end

      private

      attr_reader :prompt, :output

      def question_run(questions)
        return if questions.empty?

        do_over = questions.shuffle.reduce([]) do |redo_questions, question|
          answer = ask_the_question(question)
          display_the_question(question)
          display_the_answer(question)
          display_their_answer(answer)
          ask_about_improvement

          redo_questions.push(question) if ask_again?
          redo_questions
        end

        question_run(do_over)
      end

      def ask_again?
        prompt.yes?('Ask question again?')
      end

      def ask_the_question(question)
        prompt.say("\n")
        answer = prompt.multiline(question['question']).join("\n")
        prompt.say("\n")
        answer
      end

      def display_the_question(question)
        prompt.say('=====Question=====')
        prompt.say(question['question'])
        prompt.say("\n")
      end

      def display_the_answer(question)
        prompt.say('=====Answer=====')
        output.puts parsed = TTY::Markdown.parse(question['answer'])
        prompt.say("\n")
      end

      def display_their_answer(answer)
        prompt.say('=====Your Answer=====')
        output.puts TTY::Markdown.parse(answer)
        prompt.say("\n")
      end

      def ask_about_improvement
        improvement = prompt.ask('What could be improved about this answer?')
        prompt.say('=====Improvement=====')
        output.puts improvement
        prompt.say("\n")
      end

      def questions
        YAML.load(::File.read("#{Dir.getwd}/#{@path}"))
      end
    end
  end
end
