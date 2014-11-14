# Grapi

Grapi is a gem that works with Rails and Grape to organize and make possible the use of multiple Grape entities per model, while at the same time, decoupling them from your models.

####Important!

This project is under active development

Grape is a great framework for creating REST-like APIs, however the model representation based on grape-entity suggests a kind of coupling or uniqueness declaration per model; although you can have many entities per model, each time that you add a different representation or entity, your code will become repetitive and hard to maintain.

Multi-entities support per model enables you create multiple representations (transformations) of a single resource when your domain requires it to. There are many ways to confront this issue and there are many different API design styles that you can implement. Grapi proposes one way to solve this problem.

Grapi's main concern is about modularization and organization, the main idea is to automatically associate the models with their respective entity set through a group of conventions so that We can use these associations to easily build smart endpoints using transformations. The concept of Smart endpoints in Grapi refers to the possibility of representing a single resource on multiple urls, each one rendering a different output programmatically.

##### What are Transformations?

Each model can have several representations into business domain, each of these multiple representations is known as a transformation in the Grapi context. Grapi can generate reusable endpoints associated to the specific model, for example, you can define the "compact" and "default" transformations using Grape::Entity as a facade approach and automatically access your transformations as individual endpoints.


In Summary, Grapi is able to provide the following features:

1. Flexible approach to modularize grape entities.
2. Entities autoloading and indexing support (provides methods that allow you to find entities and transformations per model).
3. Entities generator.
4. Smart endpoints generation for a specific model.

Grapi defines a folder structure for it to automatically load your entity definitions and decouple them from your models, but lets you build and compose styles on top of it. For those parts in which you don't want to use it, you can still use Grape the regular way.

## Installation

Add this line to your application's Gemfile:

    gem 'grapi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grapi

After the gem has been installed just do:

    $ rails g grapi:install

This will create the basic directory structure and initializer file for you to configure to your needs.

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/grapi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
