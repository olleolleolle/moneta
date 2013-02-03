# Generated by generate-specs
require 'helper'

describe_moneta "adapter_datamapper" do
  def features
    [:create]
  end

  require 'dm-core'
  DataMapper.setup(:default, :adapter => :in_memory)
  def new_store
    Moneta::Adapters::DataMapper.new(:setup => "sqlite3://#{make_tempdir}/adapter_datamapper")
  end

  def load_value(value)
    Marshal.load(value)
  end

  include_context 'setup_store'
  it_should_behave_like 'concurrent_create'
  it_should_behave_like 'create'
  it_should_behave_like 'features'
  it_should_behave_like 'multiprocess'
  it_should_behave_like 'not_increment'
  it_should_behave_like 'null_stringkey_stringvalue'
  it_should_behave_like 'persist_stringkey_stringvalue'
  it_should_behave_like 'returndifferent_stringkey_stringvalue'
  it_should_behave_like 'store_stringkey_stringvalue'
  it 'does not cross contaminate when storing' do
    first = Moneta::Adapters::DataMapper.new(:setup => "sqlite3://#{make_tempdir}/datamapper-first")
    first.clear

    second = Moneta::Adapters::DataMapper.new(:repository => :sample, :setup => "sqlite3://#{make_tempdir}/datamapper-second")
    second.clear

    first['key'] = 'value'
    second['key'] = 'value2'

    first['key'].should == 'value'
    second['key'].should == 'value2'
  end

  it 'does not cross contaminate when deleting' do
    first = Moneta::Adapters::DataMapper.new(:setup => "sqlite3://#{make_tempdir}/datamapper-first")
    first.clear

    second = Moneta::Adapters::DataMapper.new(:repository => :sample, :setup => "sqlite3://#{make_tempdir}/datamapper-second")
    second.clear

    first['key'] = 'value'
    second['key'] = 'value2'

    first.delete('key').should == 'value'
    first.key?('key').should be_false
    second['key'].should == 'value2'
  end

end
