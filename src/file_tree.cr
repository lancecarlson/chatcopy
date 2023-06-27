module Chatcopy
  class FileTree
    def initialize(root_directory : String = ".")
      @root_directory = File.expand_path(root_directory)
    end

    def to_s
      code_wrap(walk(@root_directory))
    end

    private def code_wrap(code : String)
      "\n```\n" + code + "\n```\n"
    end

    private def walk(path : String, prefix : String? = nil)
      output = ""
      entries = Dir.entries(path).sort
      entries.reject! { |entry| entry == "." || entry == ".." || entry.starts_with?('.') }

      # Load .gitignore rules
      gitignore_path = File.join(path, ".gitignore")
      ignore_rules = File.exists?(gitignore_path) ? File.read_lines(gitignore_path) : [] of String

      entries.each_with_index do |entry, index|
        # Skip entry if it matches an ignore rule
        entry_path = File.join(path, entry)

        # Check if the entry is a directory and if so, if it's in the ignore_rules
        is_ignored = File.directory?(entry_path) ? ignore_rules.includes?('/' + entry + '/') : ignore_rules.includes?('/' + entry)

        next if is_ignored

        is_last = index == entries.size - 1
        connector = is_last ? "└── " : "├── "
        next_prefix = is_last ? "    " : "│   "

        output += "#{prefix}#{connector}#{entry}\n"

        # Skip symbolic links to avoid infinite recursion
        next if File.symlink?(entry_path)

        if File.directory?(entry_path)
          output += walk(entry_path, "#{prefix}#{next_prefix}")
        end
      end

      output
    end
  end
end
