# Chatcopy

Chatcopy is a simple command-line utility written in Crystal Lang that copies relevant parts of your code base into your clipboard based on a provided prompt. It uses OpenAI's GPT-3 model to parse the prompt and identify relevant code snippets.

## Dependencies
- Crystal Language
- OpenAI.cr

## Installation
To use Chatcopy, ensure that you have Crystal Language installed on your system. You can find instructions on how to do this [here](https://crystal-lang.org/install/).

Next, clone this repository to your local machine:

```
git clone https://github.com/username/chatcopy.git
cd chatcopy
```

Then, build the project:

```
crystal build src/chatcopy.cr
```

You'll also need to install OpenAI.cr. You can do this by adding it to your project's `shard.yml`:

```yaml
dependencies:
  openai:
    github: openai/openai.cr
```

Then, run `shards install`.

## Usage
To use Chatcopy, run the executable followed by the path to your prompt file:

```
./chatcopy path_to_prompt_file
```

If you do not provide a path, Chatcopy will default to using a file named `prompt.md` in the current directory.

Chatcopy will parse the prompt, identify relevant code snippets in your codebase, and copy them to your clipboard. You can then paste the code wherever you need.

For example, if your prompt file contains "I need to implement a function that reverses a string", Chatcopy will find any instances of such a function in your codebase and copy them to your clipboard.

## Support
If you encounter any issues or have any questions about Chatcopy, please open an issue [here](https://github.com/username/chatcopy/issues).

## Contributing

1. Fork it (<https://github.com/your-github-user/chatcopy/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Reques

## Contributors

- [Lance Carlson](https://github.com/your-github-user) - creator and maintainer

## License
Chatcopy is licensed under the MIT License. For more information, see [LICENSE](LICENSE).
