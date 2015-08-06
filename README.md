# SvgSpriter

Take a directory of SVG files, optimize them, and compile them into a single file using `<symbol>` elements.



Based off (svg-sprite)[https://www.npmjs.com/package/svg-sprite] for npm. This basic utility will allow you to use SVG sprites while only maintaining one instance of an SVG.

Originally built for Nanoc to build a sprite when compiling site, but can be used in any Ruby application.

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'svg_spriter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install svg_spriter

## Usage

During compile, run:

```ruby
sprite_svg(source, output)
```

where source is something like /static/svg. Output is optional, and will use the source if not specified.

## TODO

+ Allow for more robust SVGs. Currently only simple SVGs compile reliably
+ Allow for subdirectories of source directory
+ Add more tests for checking integrity of compiled sprite

## Author’s note

This is my first RubyGem, and my experience with Ruby is limited. This was a way for me to learn more about Ruby, and I don't pretend to know the best way to do things in Ruby. So, any contributions or suggestions for this gem are appreciated.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kylesimmonds/svg_spriter.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
