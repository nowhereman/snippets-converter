module SnippetsConverter
  require 'rubygems'
  require 'active_support'
  require 'fileutils'
  require 'rexml/document'

  Dir[File.dirname(__FILE__) + '/snippets_converter/editors/*.rb'].each do |file|
    require file
  end

  class Base

    def initialize; end

    def run(*args)
      @in_folder = Dir.pwd # File.dirname(__FILE__) + '/../in'
      raise Exception.new("You must have a '#{@in_folder}' folder") if !File.directory?(@in_folder)

      @out_folder = Dir.pwd + '/out' # File.dirname(__FILE__) + '/../out'
      FileUtils.mkdir_p(@out_folder) if !File.directory?(@out_folder)
      raise Exception.new("You must have a '#{@out_folder}' folder writable") if !File.directory?(@out_folder) || !File.writable?(@out_folder)

      @editor = args.first || 'Netbeans' # default editor is NetBeans
      @editor = 'Netbeans' if @editor == 'NetBeans' # Dirty fix for NetBeans editor name
      extend "SnippetsConverter::Editors::#{@editor.camelize}".constantize

      output = nil
      language = nil
      for file in Dir.glob("#{@in_folder}/**/*.tmSnippet")
        puts "Converting #{file} to #{@editor} snippet..."
        output = "#{output}#{convert(file)}"
        language = parse_tm_snippet(file)[:language] unless language
      end
      output = "#{editor_header(language)}#{output}#{editor_bottom}"

      File.open("#{@out_folder}/#{editor_target_file(language)}", "w") do |f|
        f.write(output)
      end

      puts "Result stored in '#{Pathname.new(@out_folder).realpath.to_s}/#{editor_target_file(language)}'"
      puts "**** Done ****"
    end

  end

  module ClassMethods
    include REXML

    def parse_tm_snippet(file)

      doc = Document.new( file = File.read(file) )
      i = 0
      j = 0

      arrKey = []
      arrString = []
      # Transform the key and string node into arrays
      XPath.each( doc, '//key|//string') do |key|
        if key.name == "key"
          arrKey[i] = key.text
          i+=1
        else
          arrString[j] = key.text
          j+=1
        end
      end

      tm_snippet = {}
      tm_snippet[:trigger] = arrString[arrKey.index('tabTrigger')]
      tm_snippet[:code] = arrString[arrKey.index('content')]
      tm_snippet[:description] = arrString[arrKey.index('name')]
      tm_snippet[:language] = arrString[arrKey.index('scope')]

      tm_snippet
    end

    def convert(file)
      tm_snippet = parse_tm_snippet(file)

      transform_snippet(tm_snippet[:code])
      return editor_conversion(tm_snippet[:trigger], tm_snippet[:description], tm_snippet[:code])

    end

    # Nested tab stops and place holders remover, e.g '${1: ${3:cool} $2 }' become ' ${3:cool} $2 '
    def transform_snippet(code)
      # Transform TextMate snippets syntax into snippets converter internal codes, e.g. '$' become ':dollar:'
      
        # Nested tab stops, e.g '${1: $2 }'
        nested_tab_stop = /((\$\{[0-9]{1,5}:[^${}]*)\$([0-9]{1,5})([^${}]*\}))+/m
        code.gsub!(nested_tab_stop, '\2:nested_tab_stop\3:\4')

        code.gsub!(/\$([0-9]{1,5})/, ':tab_stop\1:') # Tab Stop, e.g '$0'

       # Unescape "$", "`" and "}" if there are in plain text or in the value of a variable
        # More info at http://manual.macromates.com/en/snippets#plain_text and http://manual.macromates.com/en/snippets#variables
        code.gsub!(/\\`/, ':escape_backtick:')
        code.gsub!(/\\\$/, ':escape_dollar:')

        i = 0
        loop do
          i += 1
          break if !code.gsub!(/\{([^{}]*|[^{}]*\{[^{}]*\}[^{}]*)\\\}/, ':escape_bracket:\1:escape_close_bracket:') || i > 20
        end        

        code.gsub!(/\$([^{][^0-9]+[^:])/, ':dollar:\1') # Dollar, e.g. '$titi'

        # Place holders, e.g. '${1: cool }'
        place_holders = /\$\{((?>[^${}]+)|(\1))+\}/m
        place_holders_matches = code.scan(place_holders)
        place_holders_matches.flatten.each do |place_holder|
          if place_holder
            idx = place_holder.gsub(/([0-9]{1,5}):.+/,'\1')
            code.gsub!(/\$\{#{place_holder}\}/m, ":place_holders#{idx}:")
          end
        end
        

      #TODO Check if the regular expression in variables are correctly converted/supported
      # More info at http://manual.macromates.com/en/regular_expressions.html

      # Removed Nested place holders, e.g. '${1: ${3:cool} }' become ' ${3:cool} '
      nested_place_holders = /(\$\{[0-9]{1,5}:(([^${}]*(\$\{[0-9]{1,5}:|\{)[^${}]+\}[^${}]*)|[^${}]+)\})/m
      i = 0
      loop do
        i += 1
        break if !code.gsub!(nested_place_holders, '\2') || i > 20
      end

      # Transform snippets converter internal codes into characters, e.g. ':dollar:' become '$'
      
        place_holders_matches.flatten.each do |place_holder|
          if place_holder
            idx = place_holder.gsub(/([0-9]{1,5}):.+/,'\1')
            code.gsub!(/:place_holders#{idx}:/m, "\$\{#{place_holder}\}")
          end
        end
     
        # Nested tab stops
        code.gsub!(/:nested_tab_stop([0-9]{1,5}):/, '$\1')
        nested_tab_stop = /(\$\{[0-9]{1,5}:([^${}]*\$[0-9]{1,5}[^${}]*)\})+/m
        i = 0
        loop do
          i += 1
          break if !code.gsub!(nested_tab_stop, '\2') || i > 20
        end

        code.gsub!(/:tab_stop([0-9]{1,5}):/, '$\1')

        code.gsub!(/:escape_backtick:/, '`')
        code.gsub!(/:escape_dollar:/, '$')

        i = 0
        loop do
          i += 1
          break if !code.gsub!(/:escape_bracket:(.*):escape_close_bracket:/, '{\1}') || i > 20
        end

        code.gsub!(/:dollar:/, '$')      
     
    end

    # Dummy methods, the current Editor module must override them
      def editor_conversion(trigger, description, code)
        raise Exception.new("The current Editor module must implement this method")
      end

      def editor_header(language = nil)
        raise Exception.new("The current Editor module must implement this method")
      end

      def editor_bottom
        raise Exception.new("The current Editor module must implement this method")
      end

      def editor_target_file(language = nil)
        raise Exception.new("The current Editor module must implement this method")
      end
  end

   Base.class_eval do
     include ClassMethods
   end

end

