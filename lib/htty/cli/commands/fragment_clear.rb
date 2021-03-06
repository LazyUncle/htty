require 'htty'

# Encapsulates the _fragment-clear_ command.
class HTTY::CLI::Commands::FragmentClear < HTTY::CLI::Command

  # Returns the command that the _fragment-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::FragmentUnset
  end

end
