require "option_parser"
require "./chatcopy"

module Chatcopy
  class CLI
    DEFAULT_PATH  = "prompt.md"
    DEFAULT_MODEL = "gpt-3.5-turbo-0613"

    # Set default values for file path and model on initialization
    def initialize
      @file_path = DEFAULT_PATH
      @model = DEFAULT_MODEL

      # Parse any command line arguments
      parse_arguments
    end

    # Define how the command line arguments are parsed
    def parse_arguments
      parser = OptionParser.new do |parser|
        parser.banner = "Usage: chatcopy [options] [path to file]"

        parser.on("-m MODEL", "--model=MODEL", "Specify the OpenAI model to use") do |model|
          @model = model
        end

        parser.on("-h", "--help", "Show this help") do
          puts parser
          exit
        end
      end

      parser.parse(ARGV)

      # If a non-option argument is provided, it is the file path
      @file_path = ARGV[0] if ARGV[0]?
    end

    # Define the main functionality of the CLI
    def run
      # Then, run the main application logic
      prompt = File.read(@file_path)
      file_tree = FileTree.new
      output = FileSearcher.new(prompt, file_tree, @model).relevant_code
      output += prompt
      ClipboardManager.new(output).copy_to_clipboard
    end
  end

  # Create a new CLI instance and run it
  cli = Chatcopy::CLI.new.run
end
