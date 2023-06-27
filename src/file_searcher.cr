require "openai"
require "json"

module Chatcopy
  class FileSearcher
    class FilePathResponse
      include JSON::Serializable
      @[JSON::Field(description: "A list of file paths")]
      getter file_paths : Array(String)
    end

    def initialize(@prompt : String, @file_tree : FileTree)
      @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    end

    def relevant_files
      list_files = OpenAI.def_function("list_files", "A list of file paths", FilePathResponse)
      functions = [list_files]

      output = ""
      @client.chat("gpt-3.5-turbo-0613", [
        {role: "user", content: prepare_message},
      ], {"stream" => true, "functions" => functions}) do |chunk|
        if function_call = chunk.choices.first.delta.function_call
          print function_call.arguments
          output += function_call.arguments
        end
      end

      FilePathResponse.from_json(output).file_paths
    end

    def relevant_code
      relevant_files.map do |path|
        output = "File path: #{path}\n"
        content = File.read(path)
        output += "File content: \n#{content}\n"
        output
      end.join("\n")
    end

    private def prepare_message
      message = @prompt
      message += "\n\nFile Tree:\n"
      message += @file_tree.to_s
      message += "\n\nGiven the initial prompt and the file tree, give me a list of files that would make sense to read the code for in the next prompt:\n"
      message
    end
  end
end
