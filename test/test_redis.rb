require 'helper'

begin
  describe Juno::Redis do
    def new_store
      Juno::Redis.new
    end

    class_eval(&JunoSpecification)
    class_eval(&JunoExpiresSpecification)
  end
rescue LoadError => ex
  puts "Juno::Redis not tested: #{ex.message}"
end