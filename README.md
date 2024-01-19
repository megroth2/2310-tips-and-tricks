# 2310-tips-and-tricks
Developed by the 2310 Cohort in January 2024 after completing Mod 2.
Includes various tips and tricks relevant to ruby, rails, rspec, and vs code.
This is a living shared document - have something to add or correct? Feel free to fork, clone, and push PRs up with your favorite tips, snippets, aliases, extensions, gems, cheatsheets, etc.! We'll review and maintain as we have time.

===========================================================================

## Table of contents:
1. The .zshrc file
1. Snippets
1. Rails Joins Table Guide
1. VS Code Extensions
1. Gems
1. Misc VS Code Commands
1. Misc Tips


===========================================================================


## The .zshrc file
  - we set this up in Mod 0
  - to open, type `code ~/.zshrc` in your terminal
  - optionally, set up aliases in this file

### Aliases
Within the .zshrc file, optionally add these lines of code to set up aliases. Rename your aliases as you see fit.
- `alias pain='code ~/.zshrc'` - opens the .zshrc file
- `alias tada='source ~/.zshrc'` - after you've made a change to an alias, you have to run this command. It refreshes the file so that the alias can be used. You can also hard exit out of the terminal and re-open the terminal.
- `alias nuke='rails db:{drop,create,migrate,seed}'` - drop, create, migrate, and seed the database
- `alias ber='bundle exec rspec'` - run tests but in a special way idk why we do this actually
- `alias fixmigration='rails db:migrate RAILS_ENV=test'` - use this when you get the error: "relation "..." does not exist" but paste in the correct environment (test, development, etc.). This error likely means the rails db:migrate command did not migrate the database to the correct environment.
- `alias fixschema='bin/rails db:environment:set RAILS_ENV=development'` - @STEVE what does this one do?

### _idk what to call these - are they aliases?_
- `setopt hist_expire_dups_first` - @STEVE please provide description
- `setopt hist_find_no_dups` - @STEVE please provide description
- `setopt hist_ignore_dups` - @STEVE please provide description

### Easier way to git clone:
- Add this code to your .zshrc file:
    ```
    gcl() {
      ssh_key=$1
      repo=$(echo $ssh_key | sed 's/.*\/\(.*\)$/\1/' | cut -f 1 -d '.')
      git clone $ssh_key && cd $repo && code . 
    }
    ```
- What it does: clones the repo, drills into the repo you just cloned, and opens it in vscode in one step. Eliminates the need to git clone, cd into the directory, and then code . to open in vscode. 
- How to use: type `gcl <SSH address from github>` in your terminal, but paste in the SSH address
  - example: `gcl git@github.com:ruby/ruby.git`

### Easier way to spin up a new (greenfield) rails app:
- Add this code to your .zshrc file:
    ```
    nra() {
      app_name=$1
      rails new $app_name -T -d="postgresql" && cd $app_name && code . 
    }
    ```
- What it does: spins up a new rails repository, changes into new rails app, and open in VSCode
- How to use: type `nra <app name>` in your terminal, but paste in the app name
  - example: `nra little_shop` (@LOGAN - please confirm this is correct)


===========================================================================

## Snippets:
- .code-snippet files live in the vs code editor
- to access from vs code: `command shift p`, search "snippets", select `ruby.code-snippets` file in the search results
- To create a new snippet:
  - `command shift p`, search "snippets", select `New global snippets file...`
  - OR in the very top left corner select "Code", hover over "Settings...", select "Configure User Snippets", and within the VS Code window, select `New global snippets file...`

Snippet Example:
  ```
  "Pry command": {
      "scope": "ruby",
      "prefix": "pry",
      "body": [
        "require 'pry'; binding.pry"
      ],
      "description": "Insert a pry statement"
    }
  ```
- scope = what language is it for? This is optional, but recommended as we will likely be working with multiple languages in the future
- prefix = what command you type in the terminal to get it to populate (similar to an alias)
- $1, $2, $3 - these allow you to tab to locations to start typing. You can have multiple $1s and it will type the same thing in multiple places. 
- continue adding more snippets by adding commas in between

Examples:
- [ruby.code-snippets](ruby.code-snippets)
- [rspec.code-snippets](rspec.code-snippets)
- [erb.code-snippets](erb.code-snippets)
- [.pryrc](.pryrc)

===========================================================================

## Rails Joins Table Guide
- [Rails Joins Table Guide.md](rails-joins-table-guide.md) (developed by [Stephen Nash](https://github.com/s2an))

===========================================================================

## VS Code extensions:
### Tabnine
- https://www.tabnine.com/
- use this to write tests faster
- What it does: uses AI to auto-fill tests based on what you've already written. It will also make suggestions (i.e. try .map instead of .each)
- sometimes it is wrong
- confirmed by instructors that use of this extension at Turing is not cheating!

===========================================================================

## Gems:
### lolcat
- adds rainbow gradient colors to the output in the terminal (purely aesthetic)
- https://rubygems.org/gems/lolcat/versions/42.24.0?locale=en
- add `gem 'lolcat'` to your gemfile and run `bundle install`

===========================================================================

## Misc VS Code Commands:
- `command b` - collapse/open left menu bar in vs code
- `command shift f` - opens search in the left hand navigation bar in vs code
  - _adding shift applies the command to the whole app, whereas just command f will apply to the page you're currently on_
- `command p` = quickly open files from your explorer
- `command w` = quickly close current tab
- `command 1, 2, or 3` = opens up more panels, must have 1 to do 2, 2 to do 3, etc.

[VS Code Shortcuts & Commands](VSCode-Keyboard-Shortcuts.pdf)

===========================================================================

## Misc Tips:
- Open two terminals at once - one can have `rails s` running and you can use the other one for running tests, adding commits, etc.
  - In the top right corner of your vs code terminal, select the `+` icon
  - _note: you have to select the trash can to close these windows - simply exiting out doesn't work_
