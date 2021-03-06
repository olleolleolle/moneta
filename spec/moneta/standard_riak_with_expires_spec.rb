describe 'standard_riak_with_expires' do
  before :all do
    require 'riak'

    Riak.disable_list_keys_warnings = true
  end

  moneta_store :Riak, {bucket: 'standard_riak_with_expires', expires: true}
  use_moneta_specs STANDARD_SPECS.without_increment.with_expires.without_create
end
