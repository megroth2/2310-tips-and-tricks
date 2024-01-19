# Rails App: Joins Table Guide

_This guide's focus is to assist with adding the models needed in with joins tables. I apologize for any errors that cause you trouble._

__Note: Anywhere that has WIP, means it is a work-in-progress, so there are missing steps and information.__

## Inital Setup

### Basic Setup: Green Field

1. Open VS Code
2. `rails new application_name_here -T -d="postgresql"`
3. (WIP: _Add steps to connect to GitHub_)

### Basic Setup: Brown Field

1. Fork the Repo
2. `git clone git@github.com:Project-Owner/name-of-project.git`
3. `bundle install`
4. `bundle update`
5. `rails db:{drop,create,migrate,seed}`
6. `bundle exec rspec`
7. Correct any failed RSpec tests

### Relationships Used in This Guide
	
- Stores have many Tables. (e.g. Sells Tables, not Legs)
- Tables belong to Store.
- Tables have many Legs. (e.g. Can assemble Tables with any Legs)
- A Joins Table connects the Tables to Legs.
- Legs have many Tables. (e.g. Can assemble Legs with any Tables)

## Generate Models, Migrations, and RSpec Sheets

Rails has the generate model command to auto-generate the model, the migration, and the RSpec sheet. This not only saves time, but also reduces the chance of using the wrong "grammatical number" (e.g. singular vs. plural). This also allows for the autogeneration of the variables for each class. 
	
Example Terminal commands to use (Replace the class names and variables with your own!):

* Class names are __singular__

  `rails g model Store name:string`
	
  `rails g model Table name:string units:integer`

  `rails g model Leg name:string units:integer`

  `rails g model JoinTable table:references leg:references`
	
_Note: The example uses JoinTable for clarity. Our Turing syntax would be TableLeg or LegTable._

Now that we have generated the model, the migration, and the RSpec sheets, we need to modify them with thier relationships (and later validations). Keeping TDD in mind, we'll go to the RSpec Sheets first.

### (WIP:__Adding Validations: RSPec Sheets__)

### Adding Relationships: RSPec Sheets

For each RSpec Sheet Model that was generated we will be replacing the pending line with our relationships. (Add validations in the future)    

* `it { should belong_to(:plural) }`

* `it { should have_many(:plural) }`

__Auto-Generated Example__

```ruby
require 'rails_helper'

RSpec.describe Store, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
```

__Update spec/models/store_spec.rb__

* Relationship is __plural__

  ```ruby
  require 'rails_helper'

  RSpec.describe Store, type: :model do
    describe "relationship" do
      it { should have_many(:tables) }
    end
  end
  ```
		
__Update spec/models/table_spec.rb__

* Relationships are __plural__

  ```ruby
  require 'rails_helper'

  RSpec.describe Table, type: :model do
    describe "relationships" do
      it { should have_many(:join_tables) }
      it { should have_many(:legs).though(:join_tables) }
    end
  end
  ```
	
__Update spec/models/join_table_spec.rb__

* Relationships are __singular__

  ```ruby
  require 'rails_helper'

  RSpec.describe JoinTable, type: :model do
  describe "relationships" do
    it { should belong_to(:table) }
    it { should belong_to(:leg) }
    end
  end
  ```

__Update spec/models/leg_spec.rb__

* Relationships are __plural__

  ```ruby
  require 'rails_helper'

  RSpec.describe Leg, type: :model do
  describe "relationships" do
    it { should have_many(:join_tables) }
    it { should have_many(:tables).though(:join_tables) }
    end
  end
  ```

__Confirm Accurate RSpec Tests__

1. ```rails db:{drop,create,migrate,seed}```
2. ```bundle exec rspec```

Did they all failed accurately? They should all fail because the relationships haven't been added, but they should see the models:

3. ```git commit -m "test: Generate necessary models and write relationship/validation RSpec tests"```

### Adding Relationships: Models

Here is where we will modify the generated models and add thier relationships. (Add validations in the future)

* `belongs_to: singular`
* `has_many: plural, through: :singular_plural`
* `has_many: plural`

__Auto-Generated Example__

```ruby
class Store < ApplicationRecord
end
```

__Update app/models/store.rb__

* "has_many" relationships are :__plural__

```ruby
Class Store < ApplicationRecord
  has_many: tables
end
```

__Update app/models/table.rb__

* has_many relationships are :__plural__, through: :__singular_plural__

```ruby
Class Table < ApplicationRecord
  has_many :join_tables
  has_many :legs, through: :join_tables
end
```

__Update app/models/join_table.rb__

* belongs_to relationships are :__singular__

```ruby
Class JoinTable < ApplicationRecord
  belongs_to :table
  belongs_to :leg
end
```
		
__Update app/models/leg.rb__

* Relationships are :__plural__, through: :__singular_plural__

```ruby
Class Leg < ApplicationRecord
  has_many :join_tables
  has_many :tables, through: :join_tables
end
```

__Confirm Accurate Models__

1. `rails db:{drop,create,migrate,seed}`

2. `bundle exec rspec`

All passed? They should, and when they do:

3. `git commit -m "feat: Add model relationships and pass RSpec tests"`

### Database/Model Visual Diagram

The following is a visual description of database tables created through the models in thier migrations.

_(Insert migration file examples here)_

In our example with the Store belonging to Table, while Table is joined to the Leg through the JoinTable ("TableLeg"). It looks like this:

```
            +------------------+
            |      Store       |
            |                  |
            | has_many :tables |
            +------------------+
            
                      ^
                      |
                      |
+---------------------------------------+
|                 Table                 |
| belongs_to :store                     |
| has_many :join_tables                 |
| has_many :legs, through: :join_tables |
+---------------------------------------+
    ^                     ^
    |                     |
    |                     |
    |                     |
    |        +-----------------------+
    |        |   TableLeg/JoinTable  |
    |        |                       |
    |        | belongs_to :table     |
    |        | belongs_to :leg       |
    |        |                       |
    |        | Keys:                 |
    |        | id (primary key)      |
    |        | table_id (foreign key)|
    |        | leg_id (foreign key)  |
    |        +-----------------------+
    |                     |
    |                     |
    v                     v
+-----------------------------------------+
|                    Leg                  |
|                                         |
| has_many :join_tables                   |
| has_many :tables, through: :join_tables |
+-----------------------------------------+
```

Keep these two easy hints in mind:

* The model with the foreign key is always belongs_to!
* If there is a belongs_to, the other side needs a has_many!
* The table that the other is joined through, is joined through, you get it, the Joins Table!

## Generate Controller, Route, View, & Spec Sheet

The following outlines the terminal command to auto-generate the controller, the route, the view, and the RSpec sheet for the view. Rails generates these differently, so it requires a fair amount of editing it to conform with our style of syntax. Most notably, the spec sheets generated are in a different directory called views, whereas most of which we have put into a features directory to test our User Story. It also creates directories unfamiliar/unexplained at this point: since we don't need them, we'll delete them at the end.

The terminal command to generate the controller, route, view(s), and RSpec sheet(s) is below. Modify the syntax to contain the Class name, the view(s) you require. 

_Note: It gets a little squirrely running the generate controller command for another view if the command was already run for a different view previously. There may be a generate view command instead of controller? Either way, it won't work, but there is probably an easy work-around, so don't let me stop you!_
		
__To create a controller for the model Table, and the index view:__

* Class is __plural__

`rails g controller Tables index`
			
__You can update the syntax to create (or not create) whatever controller actions/views you want:__
			
`rails g controller Tables index show create update`

This is what the terminal should output, which listes what the command executed:

(Insert example here)

### Move and Rename the Auto-Generated view files into a features directory

You can complete the following steps by manually right-clicking and dragging and renaming the files and folders like a basic windows user, but we work with directories and a terminal, so we run the following commands.

1. Create a "features" directory in your /spec directory to move the auto-generated views into, to fit with our current style.

    * Directory is __plural__

      `mkdkir spec/features`
			
2. Move the files from the spec/views directory into contents into spec/features and rename their file name(s) to Turing syntax in one command:

    * Class is __plural__ (?????double-check this********)

      `mv spec/features/table/index.html.erb_spec.rb spec/features/table/index_spec.rb`

3. Delete the now empty "views" directory everything was moved out of:
		
    `rm -r spec/views`

4. Run the following command to delete unnessessary (to us, for now) auto-genereated directories:
		
    `rm -rf spec/helpers`

    `rm -r spec/requests`

### Update the newly moved and renamed RSpec Sheets for features/views
	
Moving into the newly moved and renamed view files in our features directory, complete the follwoing steps 

1. Modify the first line in the auto-generated example:

    ```ruby
    RSpec.describe "table/show.html.erb", type: :view do
    ```

    to our syntax:

    ```ruby 
    RSpec.describe "the table show page", type: :feature do
    ```

2. Copy/paste the User Story into Spec Sheet to build out from, if you so desire! 

3. Probably agood time to commit:
  
    `git commit -m "Create RSpec tests for User Story 1"`

#### Basic RSpec Syntaxes

Here are some of the most basic syntaxes to get you started (if you use a "before: :each" block, throw the @ in front of your variable):
	
__Create Variables__

```ruby
store_1 = Store.create!(name: "Tables R Us")
table_1 = store_1.tables.create!(name: "Oak", units: 1)
table_2 = store_1.tables.create!(name: "Pine", units: 2)
leg_1 = Leg.create!(name: "Ornate", units: 8)
```	

		
__Add to a Variable__

```ruby
leg_1.tables << table_1
leg_1.tables << table_2
store_1.tables << [table_1, table_2]
```

	
__Visit a Route__

Handrolled:

* Route is __plural__
  ```ruby
  visit "/tables"
  visit "/tables/new"
  visit "/tables/#{table.id}"
  ```
(__WIP: Path Helper:__)

* Path is __singular__

  ```ruby
  visit table_path
  ```

__Fill out a Form__

?????____drawing-a-blank____ syntax

```ruby
fill_in("name", with: "Oak")
fill_in("units", with: "1")
```	

or the ______drawing-a-blank_____ syntax

```ruby
fill_in("Name", with: "#{table_1.name}")
fill_in("Units", with: "#{table_1.units}")
```

__Click Things__

```ruby
click_on("Add Table")
click_link("#{table_1.name}")
click_button("Add Table #{table_1.name}")
uncheck("Stain Table")
```

__Expect Statements__

```ruby
expect(page).to have_content(table_1.name)
expect(page).to_not have_content(leg_1.name)
expect(page).to have_field("Add Table")
expect(page).to have_button("Add Table #{table_1.name}")
expect(page).to have_current_path("/stores/#{@store.id}/tables")
expect(current_path).to eq("/tables/#{table.id}")
expect(@table_1.name).to appear_before(@table_2.name) # <- for testing sorting
```	

## Update the Routes
	
Some basic information is added from rails g controller, but needs to be modified.
	
__Auto-Generated Example__

```ruby
Rails.application.routes.draw do
  get 'table/index' (singular for some reason...)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

__RESTful Routes__

* Routes are __plural__
* Their order is important!

```ruby
get "/tables", to: "tables#index"
get "/tables/:id", to: "tables#show"
get "/tables/new", to: "tables#new"
post "/tables", to: "tables#create"
get "/tables/:id/edit", to: "tables#edit"
patch "/tables/:id", to: "tables#update"
put "/tables/:id", to: "tables#update"
delete "/tables/:id", to: "tables#destroy"
```

__Resources Routes__

`resources :table, only: :index`

`resources :table, except: [:index, :show]`


Make sure to run your RSpec test and maybe commit

`git commit -m "feat: Create Route and pass RSpec test"`

## Update the Controller

This are is probably the least accurate (so look out for any mistakes I made), but also where the magic starts to really happen. Use.Active.Record.CRUD

__Basic Controller Templates__

```ruby
def index
  @tables = Table.all #(instance is plural, Class is singular!)
end

def show
  @table = Table.find(params[:id])
end

def new
  @table = Table.new
end

def create 
  @table = Table.new(table_params)
  if @table.save
    redirect_to @table
  else
    render :new
  end
end

def edit
  @table = Table.find(params[:id])
end

def update
  @table = Table.find(params[:id])
  if @table.update(table_params)
    redirect_to @table
  else
    render :edit
  end
end

def destroy
  Table.find(params[:id]).destroy
  redirect_to "/table/index"
end

private

def table_params
  params.require(:table).permit(:name)
end
```

Pwew! That was quick! Run your RSpec test and maybe commit

`git commit -m "feat: Update Controller with views and pass test..."`

## Update the View

Now that we used TDD to get to our view failure, we need to add our front-end nonsense.
	
__Auto-Generated Example__

```erb
<h1>Table#index</h1>
<p>Find me in app/views/table/index.html.erb</p>
```

After you create your view, run your RSpec test and pass it, then commit:

`git commit -m "feat: Update Controller with views and pass test..."`

### Basic View Examples

Below are some basic view templates to assist with a basic, functional view. A good launching off point at least, and may be snippet material...
Regardless, many mistakes may follow (I'm weakest here), and it may not be any help for the later User Stories.

_Note: Path helpers are not used in the following examples._

__Iterative Index View__

```erb
<h2>Tables Index</h2>
  <ul>
  <% @tables.each do |table| %>
    <div>
      <li>Name: <%= table.name %></li>
    </div>
    <% end %>
  </ul>
``` 

__Show Associations through Iteration__

```erb
<h2>List of Tables & Stores Associated with Legs</h2>
  <% @leg.tables.each do |table| %>
    <p>Name: <%= table.name %>
    <br>
    <p>Units: $<%= table.units %>
    <br>
    <p>Store: <%= table.store.name %>
    <br>
  <% end %>
```

__Form: Create a New Record__

```erb
<h2>New Table Form</h2>
  <%= form_with url: "/tables", method: :post, local: true do |form| %>
    <%= form.label :name %>
    <%= form.text_field :name %> 
    <br>
    <%= form.label :units %>
    <%= form.number_field :units %> 
    <br>
    <%= form.submit "Submit New Table" %>
  <% end %>
```

__Form: Add for one to another through the joins relationship__

```erb
<h2>Add Legs to Tables</h2>
  <h3>Add a leg to <%= @table.name %></h3>
    <%= form_with url: "/table/#{@table.id}", method: :post, local: true do |form|%>
    <%= form.label :leg_id, "Leg ID" %>
    <%= form.number_field :leg_id %>
    <%= form.submit "Add Leg to Table" %>
    <% end %>
```

__Form: Search for a Record__

```erb
<h2>Search for Tables</h2>
  <%= form_with url: "/tables/#{@table.id}", method: :get, local: true do |form| %>
    <%= form.label :search %>
    <%= form.text_field :search %> 
    <br>
    <%= form.submit "Search Tables" %>
    <% end %>
  <% end %>
```

__Form: Edit a Record__

```erb
<h2>Edit Table</h2>
  <%= form_with url: "/tables/#{@table.id}", method: :patch, local: true do |form| %>
    <%= form.label :name %>
    <%= form.text_field :name %>

    <%= form.label :units %>
    <%= form.number_field :units %>

    <%= form.submit %>
  <% end %>
```

__Basic Title Templates__

```erb
<h1><%= @table.name %></h1>
<p>Units: @table.units %></p>
```

__Basic Links Templates__

```erb
<%= link_to "Create New Table", "/tables/new" %>
<%= link_to "Edit #{table.name}", "/tables/#{table.id}/edit" %>
<%= link_to "Update #{table.name}", "/tables/#{table.id}/edit" %>
<%= link_to "Delete #{table.name}", "/tables/#{table.id}", method: :delete %>
<%= link_to "Sort by created method", "/tables/#{@table.id}/tables?sort=method_name" %>
```

__(Not-so-basic) Links Template__

```erb
<p class="method-name"> Tables at <%= @store.name %>: <%= @store.method_name %></p>
<p><%= link_to "All Tables at #{@store.name}", "/store/#{@store.id}/tabless" %></p>
```

__Add a Flash Method__

1. Call a flash method with the following syntax:

(WIP: `<syntax here>`)

2. Update apps/views/layouts/application.html.erb

```erb
<body>
<% flash.each do |type, msg| %>
  <div>
  <%= msg %>
</div>
  <% end %>
<%= yield %>
</body>
```

Woohoo! Go get it developer!

END