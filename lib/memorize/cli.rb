# frozen_string_literal: true

require 'thor'

module Memorize
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'memorize version'
    def version
      require_relative 'version'
      puts "v#{Memorize::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'file [PATH]', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def file(path)
      if options[:help]
        invoke :help, ['file']
      else
        require_relative 'commands/file'
        Memorize::Commands::File.new(options, path).execute
      end
    end
  end
end
