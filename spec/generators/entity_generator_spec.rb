require 'spec_helper'

require 'grape/generators/transformations/entity_generator'

describe Grape::Generators::Transformations::EntityGenerator, :type => :generator do

  destination File.expand_path('../../../tmp/tests', __FILE__)

  before { prepare_destination }

  context 'entity generating process' do

    describe 'default entity' do

      before(:each){ run_generator %w(user name:string email:string age:integer) }

      subject { file 'app/api/test_app/entities/users/default.rb' }

      it { should exist }
      it { should contain /class Default < Grape::Entity/ }
      it { should contain /expose :name, documentation: { type: 'string', desc: '', example: '' }/ }
      it { should contain /expose :email, documentation: { type: 'string', desc: '', example: '' }/ }
      it { should contain /expose :age, documentation: { type: 'integer', desc: '', example: '' }/ }

    end

    describe 'compact entity' do

      before(:each){ run_generator %w(user:compact name:string email:string) }

      subject { file 'app/api/test_app/entities/users/compact.rb' }

      it { should exist }
      it { should contain /class Compact < Grape::Entity/ }
      it { should contain /expose :name, documentation: { type: 'string', desc: '', example: '' }/ }
      it { should contain /expose :email, documentation: { type: 'string', desc: '', example: '' }/ }

    end

  end

end
