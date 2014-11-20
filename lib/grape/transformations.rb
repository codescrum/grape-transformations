require 'grape/transformations/version'
require 'grape/transformations/loader'
require 'grape/transformations/base'
require 'rails/generators'
require 'grape/generators/transformations/entity_generator'
require 'grape/generators/transformations/install_generator'
require 'grape/generators/transformations/module_generator'
require 'grape/transformations/engine' if defined?(Rails)
require 'grape'
require 'rails'

module Grape
  module Transformations
    # Sets default api location ../app/api
    mattr_accessor :root_api_path

    # relative_path_to_entities
    mattr_accessor :relative_path_to_entities

    # Uses Loader.load_entities method in order to load all valid entities located
    # in relative path_to_entities
    def self.load_entities_from(relative_path_to_entities)
      self.root_api_path ||= File.join(Rails.root, 'app', 'api')
      self.relative_path_to_entities = relative_path_to_entities
      Loader.load_entities root_api_path, relative_path_to_entities
    end

    # defines wrapped accessor to grape-transformations configurator
    def self.setup
      yield self
    end

    # returns entities registered from rails cache
    def self.registered_entities
      Rails.cache.fetch(:registered_entities)
    end

    # returns the appropite class for a class name or class
    def self.registered_entity_for(klass)
      registered_entities[normalized_class_name(klass)]
    end

    # @return [Class] the entity class for a given transformation
    # example:
    # entity_for_transformation(User, :full)
    # #=> MyApp::Entities::Users::Full
    def self.entity_for_transformation(klass, transformation)
      entity_hierarchy = root_entity_namespace_hierarchy << normalized_class_name(klass).pluralize
      entity_hierarchy << transformation.to_s.camelize
      entity_hierarchy.join('::').constantize
    end

    # @return [Array] the top level module entity namespace wrapping
    # example: ['MyApp', 'Entities']
    def self.root_entity_namespace_hierarchy
      File.split(relative_path_to_entities).map{|namespace| namespace.camelize}
    end

    # @return [String] the top level module namespacing to begin looking entities within
    # example: "MyApp::Entities"
    def self.root_entity_namespace
      root_entity_namespace_hierarchy.join('::')
    end

    # @return [String] the absolute path to entities directory
    def self.full_path_to_entities
      File.join(root_api_path, relative_path_to_entities)
    end

    # @return [Array] all transformations listed as symbols (excludes :default)
    def self.transformations_for(klass)
      simbolized_entities_for(klass) - [:default] 
    end

    def self.simbolized_entities_for(klass)
      class_name = normalized_class_name(klass)
      entities_directory = File.join(full_path_to_entities, class_name.pluralize.underscore)
      entity_files = Dir[File.join(entities_directory, '*')]
      entity_files.map{|filename| File.split(filename).last.sub('.rb', '').to_sym}
    end

    # @return [Array] all entity classes including "Default" that relate to a given class
    def self.all_entities_for(klass)
      (transformations_for(klass) + [:default]).map{|transformation| entity_for_transformation(klass, transformation)}
    end

    # @return [Array] all entity classes except for "Default" that relate to a given class
    def self.all_transformation_entities_for(klass)
      all_entities_for(klass) - [entity_for_transformation(klass, :default)]
    end

    # return the class_name given a Class or :class or "class"...or anything like it
    def self.normalized_class_name(klass)
      klass.to_s.classify
    end

    # Monkey patch for Grape::Endpoint#present so that it
    # autoloads a default entity when presenting a given class instance
    ::Grape::Endpoint.send(:define_method, :present_with_autoload) do |instance, options = {}|
      is_instance_a_set = false
      is_instance_a_set = if defined? Mongoid
        instance.kind_of?(Mongoid::Criteria)
      elsif defined? ActiveRecord
        instance.kind_of?(ActiveRecord::Relation)
      end
      is_instance_a_set ||= instance.kind_of?(Array)
      klass = is_instance_a_set ? instance.first.class : instance.class
      entity = Grape::Transformations.registered_entity_for klass
      options[:with] = entity.constantize if options[:with].nil? && entity
      present_without_autoload instance, options
    end

    ::Grape::Endpoint.alias_method_chain(:present, :autoload)

  end
end
