describe 'User Endpoint', :type => :request do

  context :v1 do
      
    let(:first_user) { User.new name: 'Allam Britto', age: 24, birthday: Date.parse('15-06-1990'), phone: '555-5555', address: 'Fake st. 1-23' }
    let(:second_user) { User.new name: 'Elva Lasso', age: 25, birthday: Date.parse('15-06-1989'), phone: '777-5555', address: 'Fake st. 1-25' }

    context 'GET' do
      describe 'default transformation' do
        before(:each){ allow(::User).to receive(:all) { [first_user, second_user] } }
        describe '/' do
          it 'gets all users with default transformation' do
            expected_response = "[{\"name\":\"Allam Britto\",\"age\":24,\"birthday\":\"1990-06-15T00:00:00.000+00:00\",\"phone\":\"555-5555\",\"address\":\"Fake st. 1-23\"},{\"name\":\"Elva Lasso\",\"age\":25,\"birthday\":\"1989-06-15T00:00:00.000+00:00\",\"phone\":\"777-5555\",\"address\":\"Fake st. 1-25\"}]"      
            get '/api/v1/users'
            expect(response.status).to eq 200
            expect(response.body).to match expected_response
            #RSpec::Mocks.space.proxy_for(::User).reset # It is not necessary
          end
        end

        describe '/compact' do
          it 'gets all users with compact transformation' do
            expected_response = "[{\"name\":\"Allam Britto\",\"phone\":\"555-5555\"},{\"name\":\"Elva Lasso\",\"phone\":\"777-5555\"}]"
            get '/api/v1/users/compact'
            expect(response.status).to eq 200
            expect(response.body).to match expected_response
          end
        end
      end
      describe 'compact transformation' do
        before(:each){ allow(::User).to receive(:find) { first_user } }
        describe '/:id' do
          it 'gets specific user with default transformation' do
            expected_response = "{\"name\":\"Allam Britto\",\"age\":24,\"birthday\":\"1990-06-15T00:00:00.000+00:00\",\"phone\":\"555-5555\",\"address\":\"Fake st. 1-23\"}"
            get '/api/v1/users/0'
            expect(response.status).to eq 200
            expect(response.body).to match expected_response
          end
        end

        describe 'compact/:id' do
          it 'gets specific user with default transformation' do
            expected_response = "{\"name\":\"Allam Britto\",\"phone\":\"555-5555\"}"  
            get '/api/v1/users/compact/0'
            expect(response.status).to eq 200
            expect(response.body).to match expected_response
          end
        end
      end

    end

  end

end
