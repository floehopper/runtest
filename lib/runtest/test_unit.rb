class Runtest::TestUnit
  def initialize(filename, line)
    @filename = filename
    @line = line
  end

  def name
    lines = File.readlines(filename)
    (line-1).downto(0) do |check|
      if lines[check] =~ /^\s+def test_/
        return lines[check].strip.gsub(/^def /, '')
      end
    end
    nil
  end

  def command_line_arguments
    %{-n "#{name}"}
  end

  private

  attr_reader :filename, :line
end
