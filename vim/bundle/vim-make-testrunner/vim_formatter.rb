# Based on RSpec's base text formatter, with tweaks to output line's VIM's quickfix 
# can understand. Tested with RSpec 2.5.
require 'rspec/core/formatters/base_text_formatter'

# Format spec results for display in the Vim quickfix window
# Use this custom formatter like this:
#   bin/rspec -r vim_formatter -f RSpec::Core::Formatters::VimFormatter spec
module RSpec
  module Core
    module Formatters
      class VimFormatter < BaseTextFormatter
        def example_failed example
          exception = example.execution_result[:exception]
          reason = exception.message.sub(/[\n\t]/, " ").strip if exception.message
          message = "#{read_failed_line(exception, example).strip}: #{reason}"
          location = format_caller example.location
          output.puts "#{location}: FAIL: #{message}"
        end

        def dump_failures *args; end

        def dump_pending *args; end

        def message msg; end

        def dump_summary duration, example_count, failure_count, pending_count; end
      end
    end
  end
end
