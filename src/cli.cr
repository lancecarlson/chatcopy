require "option_parser"
require "./chatcopy"

module Chatcopy
  class CLI
    DEFAULT_PATH  = "prompt.md"
    DEFAULT_MODEL = "gpt-3.5-turbo-0613"

    getter file_path : String
    getter model : String

    def initialize
      @file_path = ARGV[0]? || DEFAULT_PATH
    end

    def initialize
      @file_path = DEFAULT_PATH
      @model = DEFAULT_MODEL
      OptionParser.new do |parser|
        parser.banner = "Usage: chatcopy [path to file]"

        parser.on("-m MODEL", "--model=MODEL", "Specify the OpenAI model to use") { |model| @model = model }
        parser.on("-h", "--help", "Show this help") do
          puts parser
          exit
        end
      end
    end

    def run
      prompt = File.read(@file_path)
      file_tree = FileTree.new
      output = FileSearcher.new(prompt, file_tree, @model).relevant_code
      output += prompt
      ClipboardManager.new(output).copy_to_clipboard
    end
  end

  CLI.new.run
end
