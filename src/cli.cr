require "./chatcopy"
require "option_parser"

module Chatcopy
  class CLI
    DEFAULT_PATH = "prompt.md"

    getter file_path : String

    def initialize
      @file_path = ARGV[0]? || DEFAULT_PATH
    end

    def parse_arguments
      OptionParser.new do |parser|
        parser.banner = "Usage: chatcopy [path to file]"

        parser.on("-h", "--help", "Show this help") do
          puts parser
          exit
        end
      end
    rescue ex : OptionParser::Exception
      puts "Error: #{ex.message}"
      puts
      puts "Try 'chatcopy --help' for more information."
      exit
    end

    def run
      parse_arguments
      prompt = File.read(@file_path)
      file_tree = FileTree.new
      code_suggestions = FileSearcher.new(prompt, file_tree).relevant_code
      ClipboardManager.new(code_suggestions).copy_to_clipboard
    end
  end

  CLI.new.run
end
