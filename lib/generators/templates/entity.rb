module <%= app_name.classify %>
  module Entities
    module <%= entity_name.classify.pluralize %>
      class Default < Grape::Entity
        <% fields.each do |field| %>
          <% attribute, type = field.split(':')%>
          expose :<%= attribute %>, documentation: { type: '<%= type %>', desc: 'write a description here', example: 'write an example here' }
        <% end %>
      end
    end
  end
end
