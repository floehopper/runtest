require "test_helper"

class TestUnitTest < Test::Unit::TestCase
  def test_determines_test_name_when_the_line_is_on_the_method_definition
    assert_test_found "test_a_thing", "test_unit_test.rb", 2
  end

  def test_determines_test_name_when_the_line_is_within_the_method_definition
    assert_test_found "test_a_thing", "test_unit_test.rb", 3
  end

  def test_determines_test_name_when_the_line_is_at_the_bottom_of_the_method_definition
    assert_test_found "test_a_thing", "test_unit_test.rb", 4
  end

  def test_determines_the_nearest_test
    assert_test_found "test_another_thing", "test_unit_test.rb", 7
  end

  def test_generates_runner_options_for_test_unit
    target = Runtest::TestUnit.new(example("test_unit_test.rb"), 3)
    assert_equal %{-n "test_a_thing"}, target.command_line_arguments
  end

  private

  def assert_test_found(name, file, line)
    target = Runtest::TestUnit.new(example(file), line)
    assert_equal name, target.name
  end
end
