require 'htty'
require 'readline'

# Encapsulates the _body-set_ command.
class HTTY::CLI::Commands::BodySet < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _body-set_ command
  # should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _body-set_ command.
  def self.help
    'Sets the body of the request'
  end

  # Returns the extended help text for the _body-set_ command.
  def self.help_extended
    'Sets the body content used for the request. Does not communicate with ' +
    "the host.\n"                                                            +
    "\n"                                                                     +
    'Enter two blank lines, or hit Ctrl-D, to signify the end of the body.'
  end

  # Returns related command classes for the _body-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyRequest, HTTY::CLI::Commands::BodyUnset]
  end

  # Performs the _body-set_ command.
  def perform
    add_request_if_new do |request|
      puts notice('Enter two blank lines, or hit Ctrl-D, to signify the end ' +
                  'of the body')
      lines            = []
      empty_line_count = 0
      while empty_line_count < 2 do
        if (input = Readline.readline).nil?
          break
        end
        lines << input.chomp
        empty_line_count = lines.last.empty? ? (empty_line_count + 1) : 0
      end
      request.body_set lines.join("\n").gsub(/[\r\n]+$/, '')
      body = lines.join("\n")
      while body.chomp != body
        body.chomp!
      end
      request.body_set body
    end
  end

end
