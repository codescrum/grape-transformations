require 'spec_helper'

require 'generators/grapi/entity_generator'

describe Grapi::Generators::EntityGenerator, :type => :generator do

  destination File.expand_path('../../../tmp/tests', __FILE__)

  before { prepare_destination }

  context 'entity generating process' do

    describe 'simple entity' do

      before(:each){ run_generator %w(user) }

      subject { file 'app/api/test_app/entities/users/default.rb' }

      it { should exist }

    end

  end

end
