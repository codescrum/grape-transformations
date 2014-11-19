describe 'Animal Endpoint', :type => :request do

  context :v1 do

    let(:first_animal) { Animal.new name: 'Cow', description: 'Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae', phylum: 'Chordata', diet: 'vegetarian' }
    let(:second_animal) { Animal.new name: 'Capybara', description: 'is the largest rodent in the world. Its closest relatives are guinea pigs and rock cavies', phylum: 'Chordata', diet: 'vegetarian' }

    context 'GET' do
      describe '/foo' do
        before(:each){ allow(::Animal).to receive(:all) { [first_animal, second_animal] } }
        
        it 'gets all users with default transformation' do
          expected_response = "[{\"name\":\"Cow\",\"description\":\"Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae\",\"phylum\":\"Chordata\",\"diet\":\"vegetarian\"},{\"name\":\"Capybara\",\"description\":\"is the largest rodent in the world. Its closest relatives are guinea pigs and rock cavies\",\"phylum\":\"Chordata\",\"diet\":\"vegetarian\"}]"      
          get '/api/v1/animals/foo'
          expect(response.status).to eq 200
          expect(response.body).to match expected_response
          #RSpec::Mocks.space.proxy_for(::User).reset # It is not necessary
        end

      end
      describe '/bar/:id' do
        before(:each){ allow(::Animal).to receive(:find) { first_animal } }

        it 'gets specific user with default transformation' do
          expected_response = "{\"name\":\"Cow\",\"description\":\"Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae\"}"
          get '/api/v1/animals/bar/0'
          expect(response.status).to eq 200
          expect(response.body).to match expected_response
        end

      end

    end

  end

end
