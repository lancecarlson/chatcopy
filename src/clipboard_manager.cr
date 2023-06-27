module Chatcopy
  class ClipboardManager
    getter code_suggestions : String

    def initialize(@code_suggestions : String)
    end

    def copy_to_clipboard
      {% if flag?(:darwin) %}
        system "echo #{@code_suggestions.inspect} | pbcopy"
      {% elsif flag?(:unix) %}
        system "echo #{@code_suggestions.inspect} | xsel -ib"
      {% elsif flag?(:win32) %}
        system "echo #{@code_suggestions.inspect} | clip"
      {% end %}
    rescue ex
      puts "Error while copying to clipboard: #{ex.message}"
      exit
    end
  end
end
