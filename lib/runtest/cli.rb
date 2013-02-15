require "runtest"
require "thor"

class Runtest::CLI < Thor

  desc "go FILE", "Run the test from the given file on the given line"
  method_option :line, type: :numeric, required: true
  method_option :type, type: :string, required: true
  def go(file)
    line = options[:line]
    handler_class = handler_class_for(options[:type])
    puts "Running for file #{file}, line #{line}, type #{handler_class}"
    handler = handler_class.new(file, line)
    puts "ruby #{file} #{handler.command_line_arguments}"
  end

  default_task :go

  private

  def handler_class_for(type)
    case type
    when "testunit"
      Runtest::TestUnit
    when "minitest/spec"
      Runtest::MiniTest::Spec
    end
  end
end
