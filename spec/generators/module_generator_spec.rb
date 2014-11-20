require 'spec_helper'

require 'grape/generators/transformations/module_generator'

describe Grape::Generators::Transformations::ModuleGenerator, :type => :generator do

  destination File.expand_path('../../../tmp/tests', __FILE__)

  before { prepare_destination }

  context 'module generating process' do

    describe 'default entity' do

      before(:each){ run_generator %w(user) }

      subject { file 'app/api/test_app/modules/user.rb' }

      it { should exist }
      it { should contain /class User < Grape::API/ }
      it { should contain /include Grape::Transformations::Base/ }
      it { should contain /target_model ::User/ }
      it { should contain /define_endpoints do \|entity\|/ }

    end

  end

end
