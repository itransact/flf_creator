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

    it 'should format a DateTime using a String' do
      FlfCreator.format_value(DateTime.parse('2012-07-13T14:08:06'), '%Y%m%d').must_equal('20120713')
    end

    it 'should format a Date using a String' do
      FlfCreator.format_value(Date.civil(2012, 7, 13), '%Y%m%d').must_equal('20120713')
    end

    it 'should format a Time using a String' do
      FlfCreator.format_value(Time.local(2012, 07, 13, 14, 8, 6), '%Y%m%d').must_equal('20120713')
    end

    it 'should format a date using a YYYY-MM-DD String' do
      FlfCreator.format_value('2012-07-13', '%Y%m%d').must_equal('20120713')
    end

    it 'should format a date using a YYYY-M-D String' do
      FlfCreator.format_value('2012-7-1', '%Y%m%d').must_equal('20120701')
    end

    it 'should format a date using a YYYY/M/D String' do
      FlfCreator.format_value('2012/7/1', '%Y%m%d').must_equal('20120701')
    end

    it 'should format a date using a M/D/YYYY String' do
      FlfCreator.format_value('1/7/2012', '%Y%m%d').must_equal('20120701')
    end

    it 'should format a date using a MM/DD/YYYY String' do
      FlfCreator.format_value('01/07/2012', '%Y%m%d').must_equal('20120701')
    end

    it 'should format using an internal formatter' do
      FlfCreator.format_value('ABCD-efgh 1234', :alphanumeric).must_equal('ABCDefgh1234')
      FlfCreator.format_value('P.O. Box 1234', :alphanumeric_space).must_equal('PO Box 1234')
      FlfCreator.format_value('ABCD-efgh 1234', :alphabetic).must_equal('ABCDefgh')
      FlfCreator.format_value('P.O. Box 1234', :alphabetic_space).must_equal('PO Box ')
      FlfCreator.format_value('(234) 567-8901', :numeric).must_equal('2345678901')
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
