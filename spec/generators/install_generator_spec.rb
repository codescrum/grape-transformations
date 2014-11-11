require 'spec_helper'

require 'generators/grapi/install_generator'

describe Grapi::Generators::InstallGenerator, :type => :generator do

  destination File.expand_path('../../../tmp/tests', __FILE__)

  before { prepare_destination }

  context 'the generated files' do

    before { run_generator }

    describe 'initializer' do

      subject { file 'config/initializers/grapi.rb' }

      it { should exist }

    end

    describe 'entities folder' do

      subject { file 'app/api/test_app/entities/.keep' }

      it { should exist }

    end

  end

end
