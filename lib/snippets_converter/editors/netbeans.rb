module SnippetsConverter
  module Editors
    module Netbeans

      def editor_conversion(trigger, description, code)
        code.gsub!(/\$0/, '${cursor}')
        code.gsub!(/\$\{([0-9]{1,5}):((?>[^{}]+)|(\1))+\}/m, '${\1 default="\2"}')
        code.gsub!(/(\$\{([0-9]{1,5}) default\=\".+\"\}.+)\$(\2)/m, '\1${\3}')
        code.gsub!(/\$([0-9]{1,5})/, '${tabStop\1 default=""}')
        return <<-CODE
  <codetemplate abbreviation='#{trigger}' xml:space='preserve'>
    <description><![CDATA[#{description}]]></description>
    <code><![CDATA[#{code}]]></code>
  </codetemplate>
        CODE
      end

      def editor_header(language = nil)
        return <<-CODE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE codetemplates PUBLIC "-//NetBeans//DTD Editor Code Templates settings 1.0//EN" "http://www.netbeans.org/dtds/EditorCodeTemplates-1_0.dtd">
<codetemplates>
        CODE
      end

      def editor_bottom
        "</codetemplates>"
      end

      def editor_target_file(language = nil)
        "org-netbeans-modules-editor-settings-CustomCodeTemplates.xml"
      end

    end
  end
end

