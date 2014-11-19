require 'active_support/concern'

module Grape
  module Transformations
    module Base
      extend ::ActiveSupport::Concern

      module ClassMethods

        # Defines the target model associated to current transformations
        # @param [Class], Class as a reference of model, bear in mind that you 
        # need to prefix the scope resolution operator at the beginning in order
        # to point to the right model
        # example:
        #     target_model ::User
        def target_model(klass)
          @grape_transformations_target_class = klass
        end

        # Defines the endpoints that will use with the existing transformations
        # @param [Proc], all code related with transformable endpoints definition
        def define_endpoints(&block)
          @grape_transformations_endpoints = block.to_proc
        end

        # Defines the endpoints that will use with the existing transformations
        # @param [Proc], all code related with non transformable endpoints definition
        def define_non_transformable_endpoints(&block)
          @grape_transformations_non_transformable_endpoints = block.to_proc
        end

        # Invokes the block associated with transformable endpoints
        # @param [Hash], options hash that contains entity transformation definition
        def add_endpoints_with(options = {})
          return unless @grape_transformations_endpoints.is_a? Proc
          entity = options[:entity] || entity_for_transformation(:default)
          @grape_transformations_endpoints.call(entity)
        end

        # Invokes the block associated with non transformable endpoints
        def add_non_transformable_endpoints
          return unless @grape_transformations_non_transformable_endpoints.is_a? Proc
          @grape_transformations_non_transformable_endpoints.call
        end

        # Abstracts entity_for_transformation grape_transformations method using the grape_transformations_target_class variable
        def entity_for_transformation(transformation)
          Grape::Transformations.entity_for_transformation(@grape_transformations_target_class, transformation)
        end

        # Invokes both transformable and non-transformable body endpoints
        def add_endpoints
          # transformable endpoints
          Grape::Transformations.transformations_for(@grape_transformations_target_class).each do |transformation|
            entity = entity_for_transformation transformation
            namespace transformation do
              add_endpoints_with entity: entity
            end
          end
          # normal api
          add_endpoints_with entity: entity_for_transformation(:default) if Grape::Transformations.simbolized_entities_for(@grape_transformations_target_class).include? :default
          add_non_transformable_endpoints
        end
      end
    end
  end
end
