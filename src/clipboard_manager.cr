module Chatcopy
  class ClipboardManager
    getter code_suggestions : String

    def initialize(@code_suggestions : String)
    end

    def copy_to_clipboard
      tempfile = File.tempfile("chatcpy") do |f|
        f.print @code_suggestions
      end

      path = tempfile.path

      {% if flag?(:darwin) %}
        system "pbcopy < #{path}"
      {% elsif flag?(:unix) %}
        system "xsel -ib < #{path}"
      {% elsif flag?(:win32) %}
        system "clip < #{path}"
      {% end %}
    end
  end
end
