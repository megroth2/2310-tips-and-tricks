## These are shortcuts to be used from your terminal, this .zshrc file is found in your root directy when you use ". code" from the terminal

## Terminal ##

alias zsh="code ~/.zshrc" # This opens your zshrc folder from any terminal
alias reload="source ~/.zshrc" # This will reload your terminal so that your new aliases will work ASAP

# These will help remove dups when you are pressing your "up" arrow
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups

# The alias "gcl" will git clone repo, change into the cloned directory, and open it in VSCode
# So you would type "glc git@github.com:megroth2/2310-tips-and-tricks.git"
gcl() {
  ssh_key=$1
  repo=$(echo $ssh_key | sed 's/.*\/\(.*\)$/\1/' | cut -f 1 -d '.')
  git clone $ssh_key && cd $repo && code . 
}

## Rails ##
alias ber="bundle exec rspec"
alias berm="bundle exec rspec spec/models"
alias berf="bundle exec rspec spec/features"
alias nuke="bundle exec rails db:{drop,create,migrate,seed}"
alias refresh="bin/rails db:environment:set RAILS_ENV=development"
alias routes="rails routes | grep -v '/rails'" # This alias will show you your rails routes without the rails files 

# This alias "nra" will spin up a new rails repository, cd into the new rails app, and open it in VSCode
# "nra new_project"
nra() {
  app_name=$1
  rails new $app_name -T -d="postgresql" && cd $app_name && code . 
}

## Simple Cov ##
alias simp="open coverage/index.html"