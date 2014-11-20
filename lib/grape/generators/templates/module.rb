module <%= app_name.classify %>
  module Modules
    class <%= underscored_module_name.classify %> < Grape::API
      include Grape::Transformations::Base
      target_model <%= "::#{target_model}" %>
      helpers do
        # Write your helpers here
      end
      define_endpoints do |entity|
        # Write your single endpoints here
      end
      resource <%= ":#{underscored_module_name}" %> do
        add_endpoints
      end
    end
  end
end
