module <%= app_name.classify %>
  module Entities
    module <%= entity_name.classify.pluralize %>
      class <%= class_name %> < Grape::Entity
        <% fields.to_a.each do |field| %>
          <% attribute, type = field.split(':')%>
          expose :<%= attribute %>, documentation: { type: '<%= type %>', desc: '', example: '' }
        <% end %>
      end
    end
  end
end
