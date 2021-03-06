require 'spec_helper'

# TODO: Drop the Mongo test db before running specs.
describe AppConfig::Storage::Mongo do

  before(:all) do
    AppConfig.reset!
    config_for_mongo
  end

  it 'should have some values' do
    AppConfig[:api_key].should_not be_nil
  end

  it 'should update the values' do
    AppConfig.class_variable_get(:@@storage).should_receive(:save!)
    AppConfig[:api_key] = 'SOME_NEW_API_KEY'
    AppConfig[:api_key].should == 'SOME_NEW_API_KEY'
  end

  it 'should not have the Mongo _id in storage' do
    AppConfig['_id'].should be_nil
  end

  it 'should have a @_id variable for the Mongo ID' do
    AppConfig.class_variable_get(:@@storage).
      instance_variable_get(:@_id).should_not be_nil
  end
end
