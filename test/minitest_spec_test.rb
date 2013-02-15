require "test_helper"

class MinitestSpecTest < Test::Unit::TestCase
  def test_determines_test_name_when_the_line_is_on_the_method_definition
    assert_test_found "a thing#test_0001_goes_up", "minitest_spec_test.rb", 5
  end

  def test_determines_test_name_when_the_line_is_within_the_method_definition
    assert_test_found "a thing#test_0001_goes_up", "minitest_spec_test.rb", 6
  end

  def test_determines_test_name_when_the_line_is_at_the_bottom_of_the_method_definition
    assert_test_found "a thing#test_0001_goes_up", "minitest_spec_test.rb", 7
  end

  def test_determines_the_nearest_test
    assert_test_found "a thing#test_0001_goes_up", "minitest_spec_test.rb", 8
  end

  def test_correctly_predicts_the_test_names_that_minitest_spec_generates
    assert_test_found "a thing#test_0002_goes_down", "minitest_spec_test.rb", 9
  end

  def test_does_not_find_tests_when_line_is_in_describe_block
    assert_test_found nil, "minitest_spec_test.rb", 12
  end

  def test_determines_names_for_nested_tests
    assert_test_found "a thing::when jumping#test_0001_explodes", "minitest_spec_test.rb", 13
  end

  def test_determines_test_indexes_for_nested_tests
    assert_test_found "a thing::when jumping#test_0002_is_happy", "minitest_spec_test.rb", 17
  end

  def test_determines_names_for_describes_without_including_non_parent_describes_above
    assert_test_found "a thing::non nested#test_0001_doesn_t_include_when_jumping", "minitest_spec_test.rb", 22
  end

  def test_determines_names_for_describes_using_constants
    assert_test_found "a thing::SomeClass#test_0001_works", "minitest_spec_test.rb", 29
  end

  def test_generates_runner_options_for_minitest_spec
    target = Runtest::MiniTest::Spec.new(example("minitest_spec_test.rb"), 5)
    assert_equal %{-n "a thing#test_0001_goes_up"}, target.command_line_arguments
  end

  private

  def assert_test_found(name, file, line)
    target = Runtest::MiniTest::Spec.new(example(file), line)
    assert_equal name, target.name
  end
end
