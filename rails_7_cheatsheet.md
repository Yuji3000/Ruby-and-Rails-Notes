# Rails v7.1.2 Cheatsheet

Updated by: Chris Simmons, based on the [5.2 Cheatsheet by Scott Borecki](https://gist.github.com/Scott-Borecki/55c2f614117309aa788cb9bca5772f52).

Please reach out if you have any comments or suggestions for updates!

## Notes About this Cheatsheet
  * This guide uses Rails version v7.1.2. Run `rails -v` to check your Rails version number.
  * Code snippets in this cheatsheet starting with `$`:
    * Run from the terminal, usually within your project directory.
    * Do not include the `$` in your terminal command.
  * `# [...]` is used within example code blocks to indicate some code may have been omitted for brevity.
  * **Warning**:
    * This checklist does not necessarily rely on TDD to build up the Rails application.
    * It uses some code snippets with specific practical examples, so make sure to replace them as needed for your project.
  * This cheatsheet was adapted from other cheatsheets, including:
    * https://gist.github.com/brisag/aa1d849c81d591a59e68fa7854295bc3


## References

  * [Rails Guides v7.1.2](https://guides.rubyonrails.org/v7.1.2/)
  * Style Guides:
    * [The Rails Style Guide](https://rails.rubystyle.guide/)
    * [The RSPec Style Guide](https://rspec.rubystyle.guide/)
    * [The Ruby Syle Guide](https://rubystyle.guide/)
  * Turing School:
    * [Blogger](https://backend.turing.edu/module2/misc/blogger)
    * [Task Manager Repo](https://github.com/turingschool-examples/task_manager_rails)


## Table of Contents

- [Getting Started](#getting-started)
  1. [Create Rails Application](#1-create-rails-application)
  2. [Environment Setup](#2-environment-setup)
  3. [Create Database and Resources](#3-create-database-and-resources)
- [Models and Relationships](#models-and-relationships)
  - [Relationship Summary](#relationship-summary)
  - [Relationship Examples](#relationship-examples)
    - [One-to-Many](#one-to-many)
    - [Many-to-Many](#many-to-many)
- [Updating Database Schema](#updating-database-schema)
  - [Edit Table Column Data Type](#edit-table-column-data-type)
  - [Add New Column to Table](#add-new-column-to-table)
- [Testing](#testing)
- [Create Routes](#create-routes)
- [Create Controllers](#create-controllers)
- [Create Views](#create-views)
- [Rails Helpers](#rails-helpers)
  - [form_with](#form_with)
  - [validates](#validates)
  - [link_to](#link_to)

---

## Getting Started

### 1. Create Rails Application
  * From the command line, start a new rails app.  For example:  
    ```zsh
    $ rails new project_name -T -d='postgresql'
    ```
    Command-Line Flag   | Description
    ------------------- | -----------
    `new`               | Tells Rails to create a new Rails application.
    `project_name`      | The name of your project.
    `-T`                | Tells Rails we are not going to use the default rails testing database (We will be using RSpec instead - see Step 3).
    `-d='postgresql'`   | Tells Rails that we will be using a PostgreSQL database.

### 2. Environment Setup
  * Install any gems you need by inserting the gems into the Gemfile (`project_directory/gemfile`) within the `group :development, :test` code block.  This will make the gems available in your development and test environments.
    For example, some handy, often-used gems:
    ```ruby
    # Gemfile
    # [...]
    group :development, :test do
      gem 'pry'
      gem 'rspec-rails'
      gem 'capybara'
      gem 'launchy'
      gem 'simplecov'
      gem 'shoulda-matchers'
      gem 'orderly'
      # Some other gems
    end
    # [...]
    ```
    
    Then run `$ bundle install` to install the newly added gems.
    
    Gem | Description | Docs
    ----|-------------|-----
    pry | A runtime developer console and IRB alternative with powerful introspection capabilities | [docs](https://github.com/pry/pry)
    rspec-rails | Brings RSpec testing framework to Rails | [docs](https://github.com/rspec/rspec-rails)
    capybara | Helps you test web applications by simulating how a real user would interact with your app | [docs](https://github.com/teamcapybara/capybara)
    launchy | Helper class for launching cross-platform applications in a fire and forget manner | [docs](https://github.com/copiousfreetime/launchy)
    simplecov | A code coverage analysis tool for Ruby | [docs](https://github.com/simplecov-ruby/simplecov)
    shoulda-matchers | Provides RSpec- and Minitest-compatible one-liners to test common Rails functionality that, if written by hand, would be much longer, more complex, and error-prone | [docs](https://github.com/thoughtbot/shoulda-matchers)
    orderly | Rspec matcher for asserting that this appears_before(that) in rspec request specs | [docs](https://github.com/jmondo/orderly)
    
    
  * Run the following command in the terminal to install RSpec in your rails application (reference: [rspec-rails docs](https://github.com/rspec/rspec-rails)):
    ```zsh
    $ rails g rspec:install
    ```

  * Add the following simplecov configuration code in the `spec/rails_helper.rb` file at the top of the file as follows (reference: [simplecov docs](https://github.com/simplecov-ruby/simplecov)):
    ```ruby
    # spec/rails_helper.rb
    require "simplecov"
    SimpleCov.start
    # [...]
    ```

  * Add the following shoulda-matchers configuration code at the bottom of `spec/rails_helper.rb` (reference: [shoulda-matchers docs](https://github.com/thoughtbot/shoulda-matchers)):
    ```ruby
    # spec/rails_helper.rb
    # [...]
    # Configures Shoulda-Matchers to use RSpec as the test framework and full matcher libraries for Rails
    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end
    ```

  * From the command line run `$ bundle install`. Sometimes it will be necessary to run `$ bundle update` to get the latest versions of the gems.


### 3. Create Database and Resources
  * To create the database in the terminal run:
    ```zsh
    $ rails db:create
    ```

    * If you get a warning that database already exists, you likely need to `drop` the table then `create` a new table.
      In the terminal run:
      ```zsh
      $ rails db:drop
      $ rails db:create
      
      # Or you can chain multiple tasks in one command:
      
      $ rails db:{drop,create}
      
      ```

  * To generate your database migrations ([Rails Guides: AR Migrations](https://guides.rubyonrails.org/v5.2/active_record_migrations.html)) in the terminal run:

      * For "no" relationship (i.e. no foreign keys): for an example with a table called `Articles` with `title` (with `string` datatype) and `body` (with `text` datatype) columns:    
        ```zsh
        # Practical Example:

        $ rails generate migration CreateArticles title:string body:text
        ```

      * For a "belongs to" relationship: for an example with a table called `Comments` with `author_name` and `body` columns that "belongs to" the `Article` table via a foreign key:
        ```zsh
        # Practical Example:

        $ rails generate migration CreateComments author_name:string body:text article:references
        ```

      * If you need to add a relationship after you migrated (i.e. add a foreign key column): for an example with a table called `Comments` that "belongs to" the `Article` table:
        ```zsh
        # Practical Example:

        $ rails generate migration AddArticlesToComments article:references
        ```

        ```ruby
        # Practical Example:

        # db/migrate/[timestamp]_add_articles_to_comments.rb
        # [...]
        def change
                       # primary table      # adds foreign key to primary table
         add_reference :comments, :article, foreign_key: true
                                  # foreign table
        end
        ```

      * Check the generated migration file (within the `db/migrate/` directory) to make sure the table is being created with the specified columns and to add the timestamps stamps column at the bottom:
        ```ruby
        # Practical Example:
        
        # db/migrate/[timestamp]_create_articles.rb
        class CreateArticles < ActiveRecord::Migration[7.0]
          def change
            create_table :articles do |t|
              t.string :title
              t.text :body

              t.timestamps # In Rails 7, this line gets added automatically!
                           # This will create the created_at and updated_at timestamp columns for us. 
            end
          end
        end
        ```

  * After a migration is successfully generated, run `$ rails db:migrate` in the terminal.
  * Again, you can chain commands together e.g. `$ rails db:{drop,create,migrate}`. 
  * Note: When running migrations that add foriegn keys to existing tables with existing data, you will get a message similar to: 
```bash
 rails aborted!
 ActiveRecord::NotNullViolation: PG::NotNullViolation: ERROR:  null value in column "artist_id" of relation "songs" violates   not-null constraint

```
This is because your existing table has data in it with null values. Rails wants the foreign keys to always be "not null" - why would a child exist that doesn't have a parent? To get around this, you should run `rails db:{drop,create,migrate,seed}` to ensure the database gets cleared & then repopulated as it should be. (This is also assuming your `seeds.rb` file is updated with objects that reflect that new relationship.)



---

## Models and Relationships
Reference: [Rails Guides: AR Associations](https://guides.rubyonrails.org/v7.0.4/association_basics.html)


### Relationship Summary

**One-to-Many**

  * The objects on the **many** end (that `belong_to` the **one** object) should:
    * have a foreign key referencing the **one** object.
    * be **singular**.  
      * For example, "an article `has_many` comments and a comment `belongs_to` an article".
      * The table object after `belongs_to` should be singular.
      * The table objects after `has_many` should be plural.

**Many-to-Many**

  * The `joins` table should have a foreign key referencing each of the tables it `belongs_to`.  

### Relationship Examples

#### One-to-Many  

  * Create a model file (`*.rb`) in `app/models/` (e.g. `app/models/comment.rb`).  
    For example, the **many** side of the relationship (belongs_to):
    ```ruby
    # Practical Example:

    # app/models/comment.rb
    class Comment < ApplicationRecord  
       belongs_to :article   
    end
    ```

  * Create a model file (`*.rb`) in `app/models/` (e.g. `app/models/article.rb`).  
  For example, the **one** side of the relationship (has_many):
    ```ruby
    # Practical Example:
    
    # app/models/article.rb
    class Article < ActiveRecord::Base
       has_many :comments
    end
    ```

  * Create a test file (`*_spec.rb`) in `spec/models/`, (e.g. `spec/models/comment_spec.rb`).  
  For example, the **many** side of the relationship:
    ```ruby
    # Practical Example:
    
    # spec/models/comment_spec.rb
    require "rails_helper"

    describe Comment, type: :model do
       describe "relationships" do
          it { should belong_to(:article) }
       end
    end
    ```

  * Create a test file (`*_spec.rb`) in `spec/models/`, (e.g. `spec/models/article_spec.rb`).  
  For example, for the **one** side of the relationship:
    ```ruby
    # Practical Example:

    # spec/models/article_spec.rb
    require "rails_helper"

    describe Article, type: :model do
       describe "validations" do
          it { should have_many(:comments) }
       end
    end
    ```

#### Many-to-Many

  * When referring to a `CamelCased` table with multiple words, for example `SongArtists` in a test or model, use `lower_snake_case` (e.g. `song_artists`).  

  * Create a model file (`*.rb`) in `app/models/` (e.g. `app/models/tag.rb`), or add code if it has already been created for each side of the **many-to-many** relationship.  Make sure to do this for each of the many-to-many models.
    For example the **has many** side of the relationship:
    ```ruby
    # Practical Example:

    # app/models/tag.rb
    class Tag < ApplicationRecord
       has_many :taggings
       has_many :articles, through: :taggings
    end  
    ```

  * Create a join model in `app/models/`, for example, `app/models/tagging.rb`.  
    For example the join model,
    ```ruby
    # Practical Example:

    # app/models/tagging.rb
    class Tagging < ApplicationRecord
       belongs_to :tag
       belongs_to :article
    end
    ```

  * Create a test for each **has many** side of the relationship, for example, `spec/models/tag_spec.rb`.  
    For example:   
    ```ruby
    # Practical Example:

    # spec/models/tag_spec.rb
    require "rails_helper"

    describe Tag, type: :model do
       describe "relationships" do
          it {should have_many(:tagings)}
          it {should have_many(:articles).through(:taggings)}
       end
    end
    ```

  * Create a test for the joins, for example, `spec/models/tagging_spec.rb`.  
    For example:
    ```ruby
    # Practical Example:

    # spec/models/tagging_spec.rb
    require "rails_helper"

    describe Tagging, type: :model do
       describe "relationships" do
          it {should belong_to(:tag)}
          it {should belong_to(:article)}
       end
    end
    ```

---

## Updating Database Schema

### Edit Table Column Data Type
Reference: [Rails Guides: Changing Columns](https://guides.rubyonrails.org/v7.1.2/active_record_migrations.html#changing-columns)

When you need to make an edit **after** you have migrated, you should create a **new** migration.

1. Generate a new migration in the terminal.  
   For example, to change the datatype of the `body` column to `text` in the `Comments` table:
   ```zsh
   # Example Structure:

   $ rails generate migration ChangeColumnNameToBeDatatypeInTableName
   ```
   ```zsh
   # Practical Example:

   $ rails generate migration ChangeBodyToBeTextInComments
   ```

2. Open the migration file and put in the change. 
   For example:
   ```ruby
   # Example Structure:

   # db/migrate/[timestamp]_change_column_name_to_be_datatype_in_table_name.rb
   class ChangeColumnNameToBeDatatypeInTableName < ActiveRecord::Migration[7.0]
     def change
       change_column :table_name, :column_name, :datatype # This is what you put within the 'change' method code block
     end
   end
   ```

   ```ruby
   # Practical Example:

   # db/migrate/[timestamp]_change_body_to_be_text_in_comments.rb
   class ChangeBodyToBeTextInComments < ActiveRecord::Migration[7.0]
     def change
       change_column :comments, :body, :text # This is what you put within the 'change' method code block
     end
   end
   ```
3. Run `$ rails db:migrate`.

4. Check database schema file (`db/schema.rb`) to confirm the column data type has been updated.  

### Add New Column to Table
Reference: [Rails Guides: Add Column](https://guides.rubyonrails.org/v5.2/active_record_migrations.html#creating-a-standalone-migration)

1. Generate a new migration in the terminal.  
   For example, to add an `email` column to the `Comments` table:
   ```zsh
   # Example Structure:

   $ rails generate migration AddColumnNameToTableName
   ```

   ```zsh
   # Practical Example:

   $ rails generate migration AddEmailToComments
   ```

2. Open the migration file and put in the change (or to confirm it was automatically generated, if the migration name follows the form `AddXXXToYYY`).
   For example:
   ```ruby
   # Example Structure:

   # db/migrate/[timestamp]_add_column_name_to_table_name.rb
   class AddColumnNameToTableName < ActiveRecord::Migration[7.0]
     def change
       add_column :table_name, :column_name, :datatype # This will be automatically generated if migration name follows the form: "AddXXXToYYY"
                                                       # Otherwise, you can manually input.
     end
   end
   ```

   ```ruby
   # Practical Example:

   # db/migrate/[timestamp]_add_email_to_comments.rb
   class AddEmailToComments < ActiveRecord::Migration[7.0]
     def change
       add_column :comments, :email, :string # This will be automatically generated if migration name follows the form: "AddXXXToYYY"
                                             # Otherwise, you can manually input.      
     end
   end
   ```

3. Run `$ rails db:migrate`.

4. Check database schema file (`db/schema.rb`) to confirm the new column was created.   

---

## Testing
References:[Rails Guides: AR Validations](https://guides.rubyonrails.org/v7.1.2/active_record_validations.html), [Shoulda-Matchers Docs](https://github.com/thoughtbot/shoulda-matchers#matchers)

  * Create both a `models` and `features` sub-directory in the `spec` folder (e.g. `spec/models/` and `spec/features/`).
    * In general, `model` tests will test the relationships, validations, and logic of the model methods.
    * In general, `feature` tests will test the display and functionality of the views.


  * Framework for a `model` test:
    ```ruby
    # Practical Example:

    # spec/models/article_spec.rb
    require 'rails_helper'

    describe Article, type: :model do
      describe 'validations' do
        it { should validate_presence_of(:title) }
        it { should validate_presence_of(:body) }
      end
    end
    ```

  * Framework for a `feature` test:
    ```ruby
    # Practical Example:

    # spec/features/articles/index_spec.rb
    require 'rails_helper'

    RSpec.describe '/articles/index.html.erb', type: :feature do
      let!(article1) { Article.create!(title: 'Title 1', body: 'Body 1') }
      let!(article2) { Article.create!(title: 'Title 2', body: 'Body 2') }

      describe 'as a user' do
        describe 'when I visit the articles index' do
          it 'displays all the articles' do
            visit '/articles'

            expect(page).to have_content(article1.title)
            expect(page).to have_content(article2.title)
          end
        end
      end
    end
    ```

---

## Create Routes

  * Add code into `config/routes.rb`, such as one of the following examples,
    ```ruby
    # Practical Example:

    # config/routes.rb
    Rails.application.routes.draw do
      get '/articles/:id', to: 'articles#show'        # Example of a hand-rolled route
      resources :articles                             # Example using Rails resources to generate all RESTful routes
      resources :articles, only: [:index, :show]      # Example that only generates the specified routes
      resources :articles, except: [:destroy, :index] # Example that generates routes, except for the specified routes
    end
    ```

  * Uses `lower_snake_case` for controller names in the routes if it more than one word (e.g. `monster_trucks#show` for a controller named `MonsterTrucksController`).

  * Seven RESTful routes (actions): `index`, `new`, `create`, `show`, `edit`, `update`, and `destroy`

    Route                                            | HTTP Verb | URI             | Controller Action | Description
    ------------------------------------------------ | ------ | ------------------ | ------- | -----------
    `get '/articles', to: "articles#index`           | GET    | /articles          | index   | Display a list of all `articles`
    `get '/articles/new', to: "articles#new`         | GET    | /articles/new      | new     | Show form to make a new `article`
    `post '/articles', to: "articles#create"`        | POST   | /articles          | create  | Add new `article` to the database, then redirect
    `get '/articles/:id', to: "articles#show"`       | GET    | /articles/:id      | show    | Show information about a particular `article`
    `get '/articles/:id/edit', to: "articles#edit"`  | GET    | /articles/:id/edit | edit    | Show from to edit an existing `article`
    `patch '/articles/:id', to: "articles#update"`   | PATCH  | /articles/:id      | update  | Update an existing `article`, then redirect
    `delete '/articles/:id', to: "articles#destroy"` | DELETE | /articles/:id      | destroy | Delete a particular `article`, then redirect

  * To display all routes in the rails application run:
    ```zsh
    $ rails routes
    ```

  * To display all routes for a specific controller in the rails application, run:
    ```zsh
    # Example Structure:

    $ rails routes -c resource_name
    ```

    ```zsh
    # Practical Example:

    $ rails routes -c articles

    # Alternate Example:

    $ rails routes -c Article
    ```

---

## Create Controllers

  * Create a controller file (`*_controller.rb`) in `app/controllers/`
    For example, to create a controller called `ArticlesController`, this should look like `app/controllers/articles_controller.rb`.

  * Add in the framework for a controller, for example
    ```ruby
    # Practical Example:

    # app/controllers/articles_controller.rb
    class ArticlesController < ApplicationController
    end
    ```

---

## Create Views

  * Create directory under `app/views` named after the controller (e.g. `app/views/articles`) and with a file for the view, (e.g. `index.html.erb`). This should look like `app/views/articles/index.html.erb`.

---

## Rails Helpers

### form_with
Reference: [Rails Guides: Form Helpers](https://guides.rubyonrails.org/v7.1.2/form_helpers.html)

  * For a search:
    ```erb
    <!-- Practical Example: -->

    <%= form_with url: '/search', method: 'get', local: true do |form| %>
      <%= form.label :q %>
      <%= form.text_field :q %>
      <%= form.submit "Search" %>
    <% end %>
    ```

  * For a create, using a model url:
    ```erb
    <!-- This example needs updating for the first line -->
    <!-- Consider using the form with model helper -->

    <!-- Practical Example: -->

    <%= form_with url: path, local: true do |f| %>
      <%= f.label :name %>
      <%= f.text_field :name %>

      <%= f.label :breed %>
      <%= f.text_field :breed %>

      <%= f.label :age %>
      <%= f.number_field :age %>

      <%= f.submit %>
    <% end %>
    ```

### validates
References: [Rails Guides: Validations](https://guides.rubyonrails.org/v7.1.2/active_record_validations.html), [Shoulda-Matchers Docs](https://github.com/thoughtbot/shoulda-matchers#matchers)


  * Use `validates` in the model.  
    For example:
    ```ruby
    # Practical Example:

    # app/models/article.rb
    class Article < ApplicationRecord
      validates :title, presence: true
      validates :body, presence: true

      # [...]
    end
    ```

  * Use `validates_presence_of` in model tests.  
    For example:
    ```ruby
    # Practical Example:

    # spec/models/article_spec.rb
    require 'rails_helper'

    describe Article, type: :model do
      # [...]
      describe 'validations' do
        it { should validate_presence_of(:title) }
        it { should validate_presence_of(:body) }
      end
      # [...]
    end
    ```

### link_to
Reference: [Rails Guides: Path Helpers](https://guides.rubyonrails.org/v7.1.2/routing.html#creating-paths-and-urls-from-objects)

  * Use path helper with verb (e.g. `method: delete`) if the path helper is ambiguous.  
    For example:
    ```erb
    <!-- Practical Example: -->

    <%= link_to "Delete", article_path(@article), method: :delete %>
    ```
    
    
<!-- LINKS AND BADGES -->
Credit given to Scott Borecki for original 5.2 version:
[GitHub]: https://github.com/scott-borecki
[gmail]: mailto:scottborecki@gmail.com
[LinkedIn]: https://www.linkedin.com/in/scott-borecki/

[github-follow-badge]: https://img.shields.io/github/followers/scott-borecki?label=follow&style=social
[gmail-badge]: https://img.shields.io/badge/gmail-scottborecki@gmail.com-green?style=flat&logo=gmail&logoColor=white&color=white&labelColor=EA4335
[linkedin-badge]: https://img.shields.io/badge/Scott--Borecki-%23OpenToWork-green?style=flat&logo=Linkedin&logoColor=white&color=success&labelColor=0A66C2