class SnippetsConverter
  module Editors
    module Ruble
      
      def editor_conversion(trigger, description, code)
        # Need to escape double quote for description and code because Ruble doesn't seem to like it
        return <<-CODE
  snippet "#{description.gsub(/\"/,'\"')}" do |snippet|
    snippet.trigger = "#{trigger}"
    snippet.expansion = "#{code.gsub(/\"/,'\"')}"
  end

        CODE
      end

      def editor_header(language = 'source.ruby')
        return <<-CODE
require 'ruble'

with_defaults :scope => "#{language}" do |bundle|

        CODE
      end

      def editor_bottom

        "end"
      end

      def editor_target_file
        "ruble_snippets.rb"
      end

    end
  end
end
