class Runtest::MiniTest::Spec
  def initialize(filename, line)
    @filename = filename
    @line = line
  end

  def name
    lines = File.readlines(filename)[0..(line-1)].reverse.map { |l| Line.new(l) }
    nearest_test = lines.find(&:test_line?)

    if nearest_test
      describes = lines.select(&:describe_line?)
      nearest_describe = describes.first
      parent_describes = describes.select { |d| d.indent < nearest_describe.indent }
      describe_name = [nearest_describe, *parent_describes].reverse.map(&:describe_name).join("::")
      test_number = test_number(nearest_test, lines)
      if test_number
        return describe_name + test_number + nearest_test.test_name
      end
    end

    nil
  end

  def command_line_arguments
    %{-n "#{name}"}
  end

  private

  attr_reader :filename, :line

  def test_number(test_line, lines)
    first_describe = lines.find(&:describe_line?)
    sibling_test_lines = lines[0..(lines.index(first_describe))].reverse.select(&:test_line?)
    index_of_test = sibling_test_lines.index(test_line)
    if index_of_test
      index = index_of_test + 1
      "#test_#{index.to_s.rjust(4, '0')}_"
    else
      nil
    end
  end

  class Line
    attr_reader :line
    def initialize(line)
      @line = line
    end

    def indent
      line.match(/^(\s*)/)[1].length
    end

    def describe_line?
      line =~ /^\s*describe /
    end

    def test_line?
      line =~ /^\s*it "(.*)"/
    end

    def describe_name
      line.match(/^\s*describe (.*) do/)[1].gsub('"', '')
    end

    def test_name
      line.match(/^\s*it "(.*)" do/)[1].gsub(/[^\w]/, '_')
    end
  end
end
