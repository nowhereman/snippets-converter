class SnippetsConverter
  module Editors
    module Gedit
      
      def editor_conversion(trigger, description, code)
        # Need to remove dot in 'trigger' because Gedit doesn't seem to like it on the tag
        return <<-CODE
    <snippet id="#{trigger.gsub(/\./,'')}">
      <tag>#{trigger.gsub(/\./,'')}</tag>
      <description><![CDATA[#{description}]]></description>
      <text><![CDATA[#{code}]]></text>
    </snippet>
        CODE
      end

      def editor_header(language = 'ruby')
        # TODO use ARGV or get 'scope' attribute of TextMate to get the desire language
        return <<-CODE
  <?xml version='1.0' encoding='utf-8'?>
  <snippets language=\"#{language}\">
        CODE
      end

      def editor_bottom
        "</snippets>"
      end

      def editor_target_file
        "gedit_snippets.xml"
      end

    end
  end
end
