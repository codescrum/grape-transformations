require 'spec_helper'

require 'grape/generators/transformations/install_generator'

describe Grape::Generators::Transformations::InstallGenerator, :type => :generator do

  destination File.expand_path('../../../tmp/tests', __FILE__)

  before { prepare_destination }

  context 'the generated files' do

    before { run_generator }

    describe 'initializer' do

      subject { file 'config/initializers/grape-transformations.rb' }

      it { should exist }

    end

    describe 'entities folder' do

      subject { file 'app/api/test_app/entities/.keep' }

      it { should exist }

    end

  end

end
