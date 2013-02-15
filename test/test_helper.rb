require "bundler/setup"
require "test/unit"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "runtest"

module TestHelpers
  def example(path)
    File.expand_path("../examples/#{path}", __FILE__)
  end
end

Test::Unit::TestCase.send(:include, TestHelpers)
