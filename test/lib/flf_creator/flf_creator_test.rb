require_relative '../../test_helper'

describe FlfCreator do
  describe '.build_field' do
    it 'should return a space delimited, left justified field' do
      FlfCreator.build_field({:value => 'foo', :length => 5}).must_equal('foo  ')
    end

    describe 'when there is a justification value' do
      it 'should return a right justified value' do
        FlfCreator.build_field({:value => 'foo', :length => 5, :justify => 'right'}).must_equal('  foo')
      end
    end

    describe 'when there is a padding_char value' do
      it 'should return a zero padded field' do
        FlfCreator.build_field({:value => 5, :length => 5, :justify => 'right', :padding_char => '0'}).must_equal('00005')
      end
    end

    describe 'when the length of value is too large' do
      it 'should truncate' do
        FlfCreator.build_field({:value => 'foobar', :length => 3}).must_equal('foo')
      end
    end
  end

  describe '.format_value' do
    it 'should format using a proc' do
      FlfCreator.format_value('foo', Proc.new { |value| value.sub('foo','bar')}).must_equal('bar')
    end

    it 'should format a datetime using a String' do
      FlfCreator.format_value(DateTime.parse('2012-07-13T14:08:06'), '%Y%m%d').must_equal('20120713')
    end

    it 'should format a date using a String' do
      FlfCreator.format_value('2012-07-13', '%Y%m%d').must_equal Date.parse('2012-07-13').strftime('%Y%m%d')
    end
  end

  describe '.build_record' do
    it 'should return a record' do
      FlfCreator.build_record(['FOO    ', '000005', 'BAR    ']).must_equal('FOO    000005BAR    ')
    end
  end

  describe '.build_file' do
    it 'should return a record' do
      FlfCreator.build_file(['FOO    ', '000005', 'BAR    ']).must_equal("FOO    \n000005\nBAR    ")
    end
  end
end
