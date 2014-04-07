require File.expand_path("../test_helper", File.dirname(__FILE__))

class TargetTest < Test::Unit::TestCase

  should "default passed? to false" do
    assert !FactoryFaster::Target.new("foo_test.rb").passed?
  end

  should "allow skip? to be set on initialization" do
    assert FactoryFaster::Target.new("foo_test.rb", true).skip?
  end

end
