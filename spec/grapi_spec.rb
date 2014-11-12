describe Grapi do
  it 'verifies if Grapi is defined' do
    expect(defined?(Grapi)).to_not be_nil
  end
  context 'when grapi conventions have been followed' do
    describe 'grapi paths' do
      it 'verifies the root api path' do
        expected_response = 'grapi/spec/test_app/app/api'
        root_api_path = Grapi.root_api_path
        expect(root_api_path).to end_with expected_response
      end
      it 'verifies the relative path to entities' do
        expected_response = 'test_app/entities'
        relative_path_to_entities = Grapi.relative_path_to_entities
        expect(relative_path_to_entities).to match expected_response
      end
      it 'verifies the namespace related to entities' do
        expected_response = 'TestApp::Entities'
        root_entity_namespace = Grapi.root_entity_namespace
        expect(root_entity_namespace).to match expected_response
      end
      it 'verifies full path to entities' do
        expected_response = 'grapi/spec/test_app/app/api/test_app/entities'
        full_path_to_entities = Grapi.full_path_to_entities
        expect(full_path_to_entities).to end_with expected_response
      end
    end
    context 'when there are multiple entities already created' do
      it 'has registered entities' do
        expected_response = {
          "Food" => "TestApp::Entities::Food",
          "User" => "TestApp::Entities::Users::Default"
        }
        registered_entities = Grapi.registered_entities
        expect(registered_entities).to match expected_response
      end
      describe 'User' do
        it 'verifies all entities' do
          expected_response = '[TestApp::Entities::Users::Compact, TestApp::Entities::Users::Default]'
          all_entities_for_user = Grapi.all_entities_for(User).inspect
          expect(all_entities_for_user).to match expected_response
        end
        it 'verifies entity for compact transformation' do
          expected_response = 'TestApp::Entities::Users::Compact'
          entity_for_compact_transformation = Grapi.entity_for_transformation('User', 'Compact').inspect
          expect(entity_for_compact_transformation).to match expected_response
        end
        it 'verifies entity for default transformation' do
          expected_response = 'TestApp::Entities::Users::Default'
          entity_for_compact_transformation = Grapi.entity_for_transformation('User', 'Default').inspect
          expect(entity_for_compact_transformation).to match expected_response
        end
        it 'verifies all available entity transformations' do
          expected_response = '[TestApp::Entities::Users::Compact]'
          all_available_entity_transformations = Grapi.all_transformation_entities_for('User').inspect
          expect(all_available_entity_transformations).to match expected_response
        end
        it 'verifies the registered entities' do
          expected_response = 'TestApp::Entities::Users::Default'
          registered_entity = Grapi.registered_entity_for 'User'
          expect(registered_entity).to match expected_response
        end
        it 'verifies all available entity transformations' do
          expected_response = '[:compact]'
          all_available_transformations = Grapi.transformations_for('User').inspect
          expect(all_available_transformations).to match expected_response
        end
      end
      describe 'Food' do
        it 'verifies the registered entities' do
          expected_response = 'TestApp::Entities::Food'
          registered_entity = Grapi.registered_entity_for 'Food'
          expect(registered_entity).to match expected_response
        end
        it 'verifies all available entity transformations' do
          expected_response = '[]'
          all_available_transformations = Grapi.transformations_for('Food').inspect
          expect(all_available_transformations).to match expected_response
        end
      end
    end
    describe 'Grape::Endpoint' do
      describe 'User' do
        let(:user) { User.new name: 'Allam Britto', age: 24, birthday: Date.parse('15-06-1990'), phone: '555-5555', address: 'Fake st. 1-23' }
        let(:endpoint) { Grape::Endpoint.new({}, path: '/', method: 'get')}

        it 'presents a default representation' do
          endpoint.instance_variable_set :@env, {}
          expected_response = "{\"name\":\"Allam Britto\",\"age\":24,\"birthday\":\"1990-06-15T00:00:00.000+00:00\",\"phone\":\"555-5555\",\"address\":\"Fake st. 1-23\"}"
          representation = endpoint.present(user).to_json
          expect(representation).to match expected_response
        end
        it 'presents a compact representation' do
          endpoint.instance_variable_set :@env, {}
          expected_response = "{\"name\":\"Allam Britto\",\"phone\":\"555-5555\"}"
          representation = endpoint.present(user, with: TestApp::Entities::Users::Compact).to_json
          expect(representation).to match expected_response
        end
      end
      describe 'Food' do
        let(:food) { Food.new name: 'Omelette', description: 'In cuisine, an omelette or omelet is a dish made from beaten eggs quickly cooked with butter or oil in a frying pan' }
        let(:endpoint) { Grape::Endpoint.new({}, path: '/', method: 'get')}

        it 'presents a default representation' do
          endpoint.instance_variable_set :@env, {}
          expected_response = "{\"name\":\"Omelette\",\"description\":\"In cuisine, an omelette or omelet is a dish made from beaten eggs quickly cooked with butter or oil in a frying pan\"}"
          representation = endpoint.present(food).to_json
          expect(representation).to match expected_response
        end
      end
    end
  end
  context 'when grapi conventions have not been followed' do
    describe 'Animal' do
      let(:animal) { Animal.new name: 'Cow', description: 'Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae', phylum: 'Chordata', diet: 'vegetarian' }
      let(:endpoint) { Grape::Endpoint.new({}, path: '/', method: 'get')}

      it 'presents without entity representation' do
        endpoint.instance_variable_set :@env, {}
        expected_response = "{\"name\":\"Cow\",\"description\":\"Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae\",\"phylum\":\"Chordata\",\"diet\":\"vegetarian\"}"
        representation = endpoint.present(animal).to_json
        expect(representation).to match expected_response
      end
      it 'presents with compact entity representation' do
        endpoint.instance_variable_set :@env, {}
        expected_response = "{\"name\":\"Cow\",\"description\":\"Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae\"}"    
        representation = endpoint.present(animal, with: TestApp::Entities::Animals::Compact).to_json
        expect(representation).to match expected_response
      end
    end
  end
end
