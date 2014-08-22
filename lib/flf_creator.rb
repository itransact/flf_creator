require 'flf_creator/version'
require 'date'
module FlfCreator

  module Formats
    def self.numeric(value)
      value.gsub(/[^0-9]/, '')
    end
    def self.alphanumeric(value)
      value.gsub(/[^a-z0-9]+/i, '')
    end
    def self.alphanumeric_space(value)
      value.gsub(/[^a-z0-9 ]+/i, '')
    end
    def self.alphabetic(value)
      value.gsub(/[^a-z]+/i, '')
    end
    def self.alphabetic_space(value)
      value.gsub(/[^a-z ]+/i, '')
    end
  end

  def self.build_field(args = {})
    value = format_value(args[:value], args[:format])
    if value.length > args[:length].to_i
      value = value[0..args[:length].to_i-1]
    end
    padding_char = (args[:padding_char] || ' ').to_s
    padding_num = args[:length].to_i - value.length
    if args[:justify] == 'right'
      "#{padding_char * padding_num}#{value}"
    else
      "#{value}#{padding_char * padding_num}"
    end
  end

  def self.format_value(value, format)
    return value.to_s unless format and value
    case format
      when Proc
        format.call(value)
      when String
        if value.is_a?(DateTime)
          value.strftime(format)
        elsif value.is_a?(String) and value =~ /^\d{4}.\d{1,2}.\d{1,2}+?/
          DateTime.parse(value).strftime(format)
        elsif value.is_a?(String) and value =~ /^\d{1,2}.\d{1,2}.\d{4}+?/
          DateTime.parse(value).strftime(format)
        else
          format % value.to_i
        end
      when Symbol
        Formats.send(format, value)
      else
        raise "Unknown format type: #{format.class}"
    end.to_s
  end

  def self.build_record(fields)
    fields.join('')
  end

  def self.build_file(records)
    records.join("\n")
  end
end
