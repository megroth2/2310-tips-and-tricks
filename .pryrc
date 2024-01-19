# This file, like your .zshrc lives in your root directory, you can find it by opening up VSCode there
# These are aliases that you can use within a "pry" session:

Pry::Commands.block_command 'pl', "Alias for 'play -l'" do |lines| # This alias "pl" will run a line of code within pry
  pry_instance.run_command("play -l #{lines}")
end

Pry.commands.alias_command "r", "reload-code" # When you've edited your codeblock, this alias will allow you to refresh the pry session without having to exit pry

Pry.config.prompt_name = "plz help me" # Names your pry session, just edit the quotes
