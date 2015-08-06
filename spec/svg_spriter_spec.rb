require 'spec_helper'

describe SvgSpriter do

  # Define a test class to call the methods
  class TestClass; end

  before(:all) do
    @tester = TestClass.new
    @tester.extend SvgSpriter
    @tester.sprite_svg(source: 'test')

    @source = @tester.instance_variable_get(:@source)
    @output = @tester.instance_variable_get(:@output)
    @item_list = @tester.instance_variable_get(:@item_list)
    @compile_list = @tester.instance_variable_get(:@compile_list)
    @symbols_list = @tester.instance_variable_get(:@symbols_list)
    @number_of_svgs = @tester.instance_variable_get(:@number_of_svgs)
    @number_of_symbols = @tester.instance_variable_get(:@number_of_symbols)
  end

  it 'has a version number' do
    expect(SvgSpriter::VERSION).not_to be nil
  end

  it 'has a source' do
    expect(@source).not_to be nil
  end

  it 'has an output' do
    expect(@output).not_to be nil
  end

  it 'has an item list' do
    expect(@item_list).not_to be nil
  end

  it 'compiles items' do
    expect(@symbols_list).not_to be_empty
  end

  it 'gets all svg files' do
    expect(@number_of_svgs).to eq(@compile_list.count)
  end

  it 'creates sprite' do
    expect(File.exist?(@output + '/sprite.svg')).to be true
  end

  it 'adds all symbols to sprite' do
    expect(File.read(@output + "/sprite.svg").scan(/<symbol/).count).to eq(@number_of_symbols)
  end

end
