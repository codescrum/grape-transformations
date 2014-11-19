module Grape
  module Transformations
    module Loader
      # extend ActiveSupport::Autoload # TODO: Make entities autoloadable so that
      # code is live reloaded in development mode

      # Return a class by its name, id it is not valid
      # it returns nil
      # @param [String], full class name
      # @return [Object]
      def self.class_by_name(name)
        name.safe_constantize
      end

      # Loads all valid entities located in relative_path_to_entities dir, it
      # verifies if entity is valid and if it is associated with valid class.
      # When this process is accomplished is saved a hash with classname as a
      # key and its associated entity as a value (using Rails.cache)
      # @param root_api_path [String], path to api dir
      # @param relative_path_to_entities [String], relative path to entities
      def self.load_entities(root_api_path, relative_path_to_entities)
        available_entities = {}
        path_to_entities = File.join(root_api_path, relative_path_to_entities)
        api_entities_namespace = relative_path_to_entities.split('/').map { |module_name| module_name.gsub(' ','_').camelcase }.join('::')
        Dir.glob(File.join(path_to_entities, '**', '*.rb')).each do |filename|
          relative_path = filename.sub("#{path_to_entities}/", '')
          class_hierarchy = relative_path.split("/").map {|filename| filename.gsub(' ','_').camelcase.sub('.rb','')}
          class_name = class_hierarchy.join('::')
          entity_name = "#{api_entities_namespace}::#{class_name}"
          klass = class_by_name class_name
          entity = class_by_name entity_name

          # If there is a one to one match from Entities::..::Entity to ..::Klass, use it
          if entity && klass
            available_entities[class_name] = entity_name
          else
            # If not, try to find a "Default" transformation entity class
            # namespaced in the pluralized klass

            # An entity has to exist
            if entity
              # example: ['Admin', 'Billing', 'Addresses'], 'Default' = ['Admin', 'Billing', 'Addresses', 'Default']
              *transformation_hierarchy, transformation_name = class_hierarchy

              if transformation_name == 'Default'

                # example: ['Admin', 'Billing'], 'Addresses' = ['Admin', 'Billing', 'Addresses']
                *class_name_hierarchy, pluralized_transformable_class_name = transformation_hierarchy
                # example: 'Address' = "Addresses".singularize
                transformable_class_name = pluralized_transformable_class_name.singularize
                # example: Admin::Billing::Address

                class_name_hierarchy << transformable_class_name
                class_name = class_name_hierarchy.join('::')
                klass = class_by_name class_name
                # example: Admin::Billing::Address

                # a matching class was found
                if klass
                  available_entities[class_name] = entity_name
                else
                  # The entity is just an entity, no matching class... however seems like
                  # conventions were not properly followed
                end

              else
                # No one to one match or Default transformation found, no entity used
              end
            else
              puts "[WARN] - Conventions not followed? - Entity #{entity_name} was not found at #{filename}, please check"
            end
          end

        end
        register_entities available_entities
      end

      private
      # Saves entities in cache by using Rails.cache approach
      def self.register_entities(available_entities)
        Rails.cache.delete(:registered_entities) # make sure it is clean
        Rails.cache.fetch(:registered_entities){ available_entities }
      end
    end
  end
end
