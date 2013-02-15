Playing around with a test invoker that can use any test framework by
specifying a line number.

The idea would be to then convince every Ruby `$EDITOR` bundle to use this
rather than their individual cobbled-together scripts.

... but it might not be worth it. I don't know that I'm going to pursue this.

Here's how each test framework let's you focus right now:

    Test::Unit::TestCase
      -n /test_name_of_method/

    MiniTest::Unit::Testcase
      -n /test_name_of_method

    MiniTest::Spec
      -n /last part of test name/

    RSpec
      -l line

    Kintama
      -l line
