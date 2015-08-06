require 'svg_spriter/version'
require 'svg_optimizer'

module SvgSpriter

  # class SpriteItem
  #   def initialize(filename)
  #     @filename = filename
  #   end
  # end



  def sprite_svg(source: nil, output: nil)

    # if item.nil? or item.undefined? # Check for item
      # puts "SVG Spriter needs an item to sprite!" # Harass the user
      # return # End
    if source.nil? # Check for source
      puts "SVG Spriter needs a source!" # Harass the user
      return # End
    elsif File.directory?(source) == false # Check if source is a directory
      puts "Source is not a directory, or directory doesn't exit."
      return # End
    end

    # @item = SpriteItem.new(item) # Define current item
    @source = source.to_s.chomp('/') # Get source and remove trailing slash
    @output = output.nil? ? @source : output.to_s.chomp('/') # Get output and remove trailing slash. Set to source if nil

    list_items()
  end



  def list_items
    @item_list = nil
    @item_list = Dir[@source + "/*.svg"] # Get the list of all sprites in @source
    @item_list.delete(@source + "/sprite.svg") # Remove sprite.svg from list
    @compile_list = @item_list.uniq # Remove any duplicates from item list

    @defs_list = ''
    @symbols_list = ''
    @number_of_svgs = 0

    @compile_list.each_with_index do |v, i|
      # $current_item = SpriteItem.new v
      @number_of_svgs += 1 # Take a count of how many SVGs there are
      compile_item v
    end

    @number_of_symbols = @symbols_list.scan(/<symbol/).count
    compile_sprite()
  end



  def compile_item(current_item)
    svg = File.read current_item.to_s # Read the current svg
    id = svg[/id=('|")(.*?)('|")/, 2] # Get id
    vb = svg[/viewBox=(\'|")(.*?)('|")/, 2] # Get viewbox
    par = svg[/preserveAspectRatio=(\'|")(.*?)('|")/, 2] # Get preserveAspectRatio
    # Make sure the three attributes exist
    add_id = id ? "id='#{id}'" : nil
    add_vb = vb ? " viewBox='#{vb}'" : nil
    add_par = par ? " preserveAspectRatio='#{par}'" : nil

    optimized_svg = SvgOptimizer.optimize svg # Optimize the svg
    symbol = optimized_svg.gsub /<svg (.*?)>/m, "<symbol #{add_id}#{add_vb}#{add_par}>" # Replace the optimized svg tag with a symbol, the id, the viewBox and preserveAspectRatio, if there is one
    symbol = symbol.gsub '</svg>', '</symbol>'

    defs = symbol[/<defs>(.*?)<\/defs>/m, 1] # Get svg's defs, if any
    sans_defs = nil
    if defs
      pre_defs = symbol[/(.*?)<defs>(.*?)<\/defs>(.* ?)/m, 1] # Get symbol before defs
      post_defs = symbol[/(.*?)<defs>(.*?)<\/defs>(.* ?)/m, 3] # Get symbol after defs
      sans_defs = "#{pre_defs}#{post_defs}" # Put them together to remove the defs
      defs = defs.gsub />\s+</,"><" # Remove all extra space
      @defs_list << defs # Add the defs to the insertion list for the sprite
    end

    symbol = sans_defs ? sans_defs : symbol # Set the variable to the symbol without defs, if applicable
    symbol = symbol.gsub />\s+</,"><" # Remove all extra space
    @symbols_list << symbol # Add the symbol to the insertion list for the sprite
  end



  def compile_sprite
    $f = File.open @output + '/sprite.svg', 'w+' # Open or create sprite.svg
    $f.truncate 0 # Delete contents of sprite.svg
    $f << '<svg version="1.1" id="icon-sprite" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" xml:space="preserve">' # Add svg open tag

    unless @defs_list.empty? # Don't add the defs if there aren't any
      @defs_list = @defs_list.gsub(/>\s+</,"><").strip # Trim the defs before adding
      $f << "<defs>#{@defs_list}</defs>" # Add the defs to the sprite
    end
    $f << @symbols_list # Add the symbols to the sprite
    $f << '</svg>' # Close the svg tag

    $f.close # Close the file
    return $f # Send it back to go to the output
  end
end
