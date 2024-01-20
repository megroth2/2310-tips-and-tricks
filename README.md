# 2310-tips-and-tricks
Developed by the 2310 Cohort in January 2024 after completing Mod 2. </br>

Includes various tips and tricks relevant to ruby, rails, rspec, and vscode. </br>

This is a living shared document - have something to add or correct? Feel free to fork, clone, and push PRs up with your favorite tips, snippets, aliases, extensions, gems, cheatsheets, etc.! We'll review and maintain as we have time. </br>

===========================================================================

## Table of contents:
1. [The .zshrc File](#The-zshrc-File)
1. [Snippets](#Snippets)
1. [VSCode Commands](#VSCode-Keyboard-Shortcuts)
1. [VSCode Extensions](#VSCode-Extensions)
1. [Gems](#Gems)
1. [Misc. Tips](#Misc-Tips)
2. [Other Resources](#Other-Resources)


===========================================================================


## The .zshrc File
  - Can't find your .zshrc file? See [Mod 0 Instructions](https://mod0.turing.edu/computer-setup#install-rbenv)
  - To open: run `code ~/.zshrc` in your terminal
  - What does it do? Stores custom terminal shortcuts like Aliases and Shell commands.

### Configuration Settings:
Add the following lines of code to adjust settings and options:
  - `setopt hist_expire_dups_first` - causes Zsh to remove duplicates from the command history before expiring old entries. In other words, if there are duplicate commands in the history, Zsh will keep only the latest occurrence of each unique command.
  - `setopt hist_find_no_dups` - Zsh will not display duplicates when searching through command history using the Ctrl+R (reverse search) feature. It helps in avoiding redundant entries when searching for a previously executed command.
  - `setopt hist_ignore_dups` - instructs Zsh to ignore duplicates when adding commands to the history. If a command is already present in the history, it won't be duplicated. This is useful to keep the history cleaner by avoiding redundant entries.

### Aliases
Within the .zshrc file, add these lines of code to set up aliases. Rename your aliases as you see fit.
- `alias pain='code ~/.zshrc'` - opens the .zshrc file
- `alias tada='source ~/.zshrc'` - after you've made a change to an alias, you have to run this command. It refreshes the file so that the alias can be used. You can also hard exit out of the terminal and re-open the terminal.
- `alias nuke='rails db:{drop,create,migrate,seed}'` - drop, create, migrate, and seed the database
- `alias ber='bundle exec rspec'` - run tests but in a special way idk why we do this actually
- `alias fixmigration='rails db:migrate RAILS_ENV=test'` - use this when you get the error: "relation "..." does not exist" but paste in the correct environment (test, development, etc.). This error likely means the rails db:migrate command did not migrate the database to the correct environment.
- `alias fixschema='bin/rails db:environment:set RAILS_ENV=development'` - @STEVE what does this one do?

### Shell Commands:
- #### Quickly git clone a new repo:
  - Add this code to your .zshrc file:
      ```ruby
      gcl() {
        ssh_key=$1
        repo=$(echo $ssh_key | sed 's/.*\/\(.*\)$/\1/' | cut -f 1 -d '.')
        git clone $ssh_key && cd $repo && code . 
      }
      ```
  - What it does: clones the repo, drills into the repo you just cloned, and opens it in vscode in one step. Eliminates the need to git clone, cd into the directory, and then code . to open in vscode. 
  - How to use: type `gcl <SSH address from github>` in your terminal, but paste in the SSH address
    - example: `gcl git@github.com:ruby/ruby.git`

- #### Quickly spin up a new (greenfield) rails app:
  - Add this code to your .zshrc file:
      ```ruby
      nra() {
        app_name=$1
        rails new $app_name -T -d="postgresql" && cd $app_name && code . 
      }
      ```
  - What it does: spins up a new rails repository, changes into new rails app, and open in VSCode
  - How to use: type `nra <app name>` in your terminal, but paste in the app name
    - example: `nra little_shop` (@LOGAN - please confirm this is correct)


===========================================================================

## Snippets
- To access snippets from VSCode: `command shift p`, search "snippets", select `ruby.code-snippets` file in the search results
- To create a new snippet:
  - `command shift p`, search "snippets", select `New global snippets file...`
  - OR in the very top left corner select "Code", hover over "Settings...", select "Configure User Snippets", and within the VSCode window, select `New global snippets file...`
- The file lives here: Users/homename/Library/ApplicationSupport/Code/User/snippets folder

Snippet Examples:
  ```ruby
  "Pry command": {
    "scope": "ruby",
    "prefix": "pry",
    "body": [
      "require 'pry'; binding.pry"
    ],
    "description": "Insert a pry statement"
  }
  ```
  ```ruby
  "has_many_through": {
    "scope": "ruby",
    "prefix": "has_many_through",
    "body": [
      "has_many :$1, through: :$2"
    ]
  }
  ```

- scope = what language is it for? _This is optional, but recommended as we will likely be working with multiple languages in the future_
- prefix = what command you type in the terminal to get it to populate (similar to an alias)
- $1, $2, $3 - these allow you to tab to locations to start typing. You can have multiple $1s and it will type the same thing in multiple places. 
- continue adding more snippets by adding commas in between

Snippet File Templates and Examples:
- [ruby.code-snippets](ruby.code-snippets)
- [rspec.code-snippets](rspec.code-snippets)
- [erb.code-snippets](erb.code-snippets)
- [.pryrc](.pryrc)

===========================================================================

## VSCode Keyboard Shortcuts

View/Download this cheatsheet of keyboard shortcuts for macOS: [VSCode Shortcuts](VSCode-Keyboard-Shortcuts.pdf)

Some of our favorites:
- `command b` - Toggle left sidebar visibility
- `command shift E` - quickly open explorer
- `command shift F` - quickly open text finder
- `command p` = quickly open files from your explorer
- `command w` = quickly close current tab
- Navigate between "panels" in vscode using `command #`
  - when you have one panel open, run `command 2` to open a second panel
  - when you have two panels open, run `command 3` to open a third panel
  - run `command 1`, `command 2`, `command 3`, etc. to quickly navigate between panels

_note: adding shift to a shortcut applies it to the whole app, whereas shortcuts without shift will apply only to the current tab. For example, use `command shift F` (⇧⌘F) to find text within the whole app vs. `command f` (⌘f) to find text within the current tab._

===========================================================================

## VSCode Extensions
- [Tabnine](https://www.tabnine.com/)
  - use this to write tests faster
  - What it does: uses AI to auto-fill tests based on what you've already written. It will also make suggestions (i.e. try .map instead of .each), but sometimes it's wrong.
  - confirmed by instructors that use of this extension at Turing is not cheating!

===========================================================================

## Gems
- [lolcat](https://rubygems.org/gems/lolcat/versions/42.24.0?locale=en)
  - adds rainbow gradient colors to the output in the terminal (purely aesthetic)
  - add `gem 'lolcat'` to your gemfile and run `bundle install`

===========================================================================

## Misc. Tips
- Open multiple terminal sessions at once in VSCode:
  - In the top right corner of your VSCode terminal, select the `+` icon
  - run `rails s` in one to keep the local server running, and use another for running tests, adding commits, etc.
  - _note: you have to select the trash can to close these sessions - simply exiting out doesn't work_

===========================================================================

## Other Resources
- [Rails Joins Table Guide.md](rails-joins-table-guide.md) (developed by [Stephen Nash](https://github.com/s2an))
    
