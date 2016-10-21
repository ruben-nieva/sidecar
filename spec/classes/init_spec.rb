require 'spec_helper'
describe 'sidecar' do
  context 'with default values for all parameters' do
    it { should contain_class('sidecar') }
  end
end
