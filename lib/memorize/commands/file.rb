# frozen_string_literal: true
require 'yaml'
require 'tty-markdown'
require 'tty-prompt'
require 'tty-progressbar'
require 'tty-table'
require 'pastel'
require_relative '../command'

module Memorize
  module Commands
    class File < Memorize::Command
      def initialize(options, path)
        @options = options
        @path = path
        @prompt = TTY::Prompt.new
        @pastel = Pastel.new
      end

      def execute(input: $stdin, output: $stdout)
        @output = output
        question_run(questions)
      end

      private

      attr_reader :prompt, :output, :bar, :pastel

      def question_run(questions)
        return if questions.empty?
        number_of_questions = questions.length

        prompt.say("\n")
        prompt.say("\n")
        prompt.say("\n")
        @bar = TTY::ProgressBar.new("Progress [:bar] :percent", head: '>', total: number_of_questions)
        bar.render

        do_over = questions.shuffle.reduce([]) do |redo_questions, question|
          answer = ask_the_question(question)
          system("clear")
          render_table(question, answer)
          improvement = ask_about_improvement
          system("clear")
          render_table(question, answer, improvement)

          redo_questions.push(question) if ask_again?
          system("clear")
          display_question_position

          redo_questions
        end

        bar.finish
        question_run(do_over)
      end

      def display_question_position
        prompt.say("\n")
        bar.advance
        prompt.say("\n")
      end

      def ask_again?
        formatted_question = format_question('Ask question again?')
        prompt.yes?(formatted_question)
      end

      def ask_the_question(question)
        prompt.say("\n")
        formatted_question = format_question(question['question'])
        answer = prompt.multiline(formatted_question).join("\n")
        prompt.say("\n")
        answer
      end

      def ask_about_improvement
        formatted_question = format_question('What could be improved about this answer?')
        prompt.ask(formatted_question)
      end

      def format_question(question)
        pastel.green(question)
      end

      def format_row_heading(heading)
        pastel.cyan(heading)
      end

      def render_table(question_hash, askee_answer, improvement = nil)
        rows = [
          ['Question', TTY::Markdown.parse(question_hash['question'])],
          ['Answer', TTY::Markdown.parse(question_hash['answer'])],
          ['Your Answer', TTY::Markdown.parse(askee_answer)],
        ]

        rows << ['Improvement', TTY::Markdown.parse(improvement)] unless improvement.nil?

        rows.map do |row|
          row[0] = format_row_heading(row[0])
          row
        end

        puts TTY::Table.new(rows).render(:ascii, multiline: true, padding: 1)
      end

      def questions
        YAML.load(::File.read("#{Dir.getwd}/#{@path}"))
      end
    end
  end
end
