# Grape Transformations

[![Code Climate](https://codeclimate.com/github/codescrum/grape-transformations/badges/gpa.svg)](https://codeclimate.com/github/codescrum/grape-transformations)
[![Test Coverage](https://codeclimate.com/github/codescrum/grape-transformations/badges/coverage.svg)](https://codeclimate.com/github/codescrum/grape-transformations)

grape-transformations is a gem that works with Rails and Grape to organize and make possible the use of multiple Grape entities per model, while at the same time, decoupling them from your models.

[Grape](http://intridea.github.io/grape/) is a great framework for creating REST-like APIs, however the model representation based on grape-entity suggests a kind of coupling or uniqueness declaration per model; although you can have many entities per model, each time that you add a different representation or entity, your code will become repetitive and hard to maintain.

Multi-entities support per model enables you create multiple representations (transformations) of a single resource when your domain requires it to. There are many ways to confront this issue and there are many different API design styles that you can implement. grape-transformations proposes one way to solve this problem.

grape-transformations's main concern is about modularization and organization, the main idea is to automatically associate the models with their respective entity set through a group of conventions so that We can use these associations to easily build smart endpoints using transformations. The concept of Smart endpoints in grape-transformations refers to the possibility of representing a single resource on multiple urls, each one rendering a different output programmatically.

##### What are Transformations?

Each model can have several representations or variations into business domain, each of these multiple representations is known as a transformation in the **grape-transformations'** context. Grapi can generate reusable endpoints associated to the specific model, for example, you can define the "compact" and "default" transformations using Grape::Entity as a facade approach and automatically access your transformations as individual endpoints.

##### What are Smart Endpoints?
Smart Endpoints are the grape-transformation’s concept associated with the way multiple endpoints are rendered based on a single original endpoint definition. However you should follow some conventions related to the naming and namespacing of entities for this to automatically work

First of all, you need to define an entity set associated with the transformations that you want to use per model, these entities (classes that inherit Grape::Entity) should be defined into a specific namespace named “entities” in order to follow the internal conventions, so your folder structure should be similar to:

![alt tag](https://raw.githubusercontent.com/Johaned/songbook/c33c4dc5a1bee6667595d4f8b0cbf4bd6520661c/app/assets/images/folder%20structure.png)

In the picture above, the "entities" folder groups all defined transformations for each model, in this case, the only available transformations belong to the User model. however you don’t have to build all of this from scratch, the grape-transformations gem helps you with easy to use generators so you don't have to.

Once you have created your entities in the right folders, you can use the smart endpoint definition into your api modules, even though the API modules are not necessary to make your API run, grape and grape-transformations suggest that the API be decoupled through the use of entities and modules.

Secondly, you need to build another folder called “modules” and segregate the API's complexity through the division of endpoints grouped either by model or however you see fit according to your business domain. Finally your directory structure would be similar to:

![alt tag](https://raw.githubusercontent.com/Johaned/songbook/c33c4dc5a1bee6667595d4f8b0cbf4bd6520661c/app/assets/images/full%20folder%20structure.png)

In the picture above, we have the User module which typically defines the endpoints associated with the User stack. In this same module you can define the smart endpoints associated to the User model by using the DSL methods defined by grape-transformations which are: **define_endpoints**, **define_non_transformable_endpoints** and **add_endpoints**. Refer to the **Usage** section to catch up with the syntax stuff.
The grape-transformations' DSL allows you to write your traditional endpoint structure associated with single endpoint behavior and will take your original definitions and add the smart endpoints (endpoints related with the transformations) for you. Bear in mind that the [grape-entity](https://github.com/intridea/grape-entity) gem allows you create representations that can have attributes manipulated through blocks, which means that you can expose new attributes (e.g. virtual attributes, computed properties, and so on).


In Summary, **grape-transformations** is able to provide the following features:

1. Flexible approach to modularize grape entities.
2. Entities autoloading and indexing support (provides methods that allow you to find entities and transformations per model).
3. Entities generator.
4. Smart endpoints generation for a specific model.

## Installation

Add this line to your application's Gemfile:

    gem 'grape-transformations'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape-transformations

After the gem has been installed just do:

    $ rails g grape:transformations:install

This will create both the basic directory structure and initializer file for you to configure to your needs.

## Usage

You need to build the entities associated with your endpoint, in this case we're going to build some entities related to the User model, User model has the following attributes:

    class User
      attr_accessor :name, :email, :age, :address
    end
    
as you can see you could use plain old ruby objects or use  or Mongoid models, grape-transformations is weakly dependent on the type of ORM/ODM you use and most probably this dependency will be completely removed in the future.

In order to start building our entities, we can help ourselves by generating it by issuing a command like the following: 

    $ rails g grape:transformations:entity User name:string email:string age:integer address:string
    
at the end of this process you should have the following generated code

    # app/api/<app_name>/entities/user/default.rb
    module AppName
      module Entities
        module Users
          class Default < Grape::Entity
            expose :name, documentation: { type: "string", desc: "", example: "" }
            expose :email, documentation: { type: "string", desc: "", example: "" }
            expose :age, documentation: { type: "integer", desc: "", example: "" }
            expose :address, documentation: { type: "string", desc: "", example: "" }
          end
        end
      end
    end
    
this generator will create an entity as a default transformation using the conventions shown in the "What are Smart Endpoints?" section.

Similarly, you can create an entity that represents a specific transformation:

    $ rails g grape:transformations:entity user:compact name:string email:string

once, again the following code is generated

    module AppName
      module Entities
        module Users
          class Compact < Grape::Entity
            expose :name, documentation: { type: "string", desc: "", example: "" }
            expose :email, documentation: { type: "string", desc: "", example: "" }
          end
        end
      end
    end
    
As you can see, you can specify the name of your transformation through suffix in the first param (model name). You can create as many entities as you want.

Once you have created all entities that you need, you can now create an API module that contains the endpoints specification associated with the User model. In order to accomplish this, we can execute the following generator

    $ rails g grape:transformations:module user
    
at the end of this process you should have the following generated code:

    module AppName
      module Modules
        class User < Grape::API
          include Grape::Transformations::Base
          target_model ::User
          helpers do
            # Write your helpers here
          end
          define_endpoints do |entity|
            # Write your single endpoints here
          end
          resource :users do
            add_endpoints
          end
        end
      end
    end

Once you have defined both entities and modules, you need to mount the modules in your API core, following the grape conventions this file should be located into the "api" folder.

    # app/api/api.rb
    class API < Grape::API
      prefix 'api'
      mount AppName::Modules::User
    end

In order to create your single endpoints you need to edit the endpoints definitions into the define_enpoints block that is located in each module that you have created. In our example, we are going to create a single endpoint to get all user and get a specific user by id (as a path param in our URL).

    module AppName
      module Modules
        class User < Grape::API
          include Grape::Transformations::Base
          target_model ::User
          helpers do
            # Write your helpers here
          end
          define_endpoints do |entity|
            desc 'returns all existent users', {
              entity: entity
            }
            get '/' do
              content_type "text/json"
              present ::User.all, with: entity
            end
    
            desc 'returns specific user by id', {
              entity: entity
            }
            get '/:id' do
              content_type "text/json"
              user = ::User.find(params[:id])
              present user, with: entity
            end
          end
          
          version :v1 do
            resource :users do
              add_endpoints
            end
          end
        end
      end
    end

In the previous code, we have built four endpoints based on two initial original single endpoints, and we have defined these endpoints into version 1 in our API, this code also assume that User model provide us both "find" and "all" class methods. the created endpoints created are the following:

![alt tag](https://raw.githubusercontent.com/Johaned/songbook/c33c4dc5a1bee6667595d4f8b0cbf4bd6520661c/app/assets/images/endpoints.png)

Bear in mind that if you don’t want to use the smart endpoints feature you can write your endpoints as you always have using Grape. you can do that using the following DSL method into your module:

    define_non_transformable_endpoints do
      desc 'returns all existent foo into users', {
        entity: YourEntity
      }
      get '/foo' do
        content_type "text/json"
        present ::Foo.all, with: YourEntity
      end
    end

If you want to see an online example you can access [here](https://songbook-webday.herokuapp.com/api_doc), source code is [here](https://github.com/Johaned/songbook)

The example app integrates: rails, mongoid, grape, grape-entity, grape-swagger and grape-transformations to give your the ultimate solution in API building

TODO: Write usage instructions here

## Contributors
<ul>
  <li><a href="https://github.com/johaned">Johan Tique</a></li>
  <li><a href="https://github.com/gato_omega">Miguel Diaz</a></li>
</ul>

## Contributing

1. Fork it ( http://github.com/codescrum/grape-transformations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
