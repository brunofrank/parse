class Config
  CONFIG_FILE_NAME = 'config'

  def parse
    config_hash = {}
    IO.readlines(CONFIG_FILE_NAME).each do |line|
      item = parse_line(line)
      config_hash.merge!(item) if item
    end

    config_hash
  end

  private

  def parse_line(line)
    parsed_line = line.gsub(/#.*/, '')
    parsed_line = parsed_line.match(/(.+)=(.+)/)

    { parsed_line[1].strip.to_sym => type_cast_value(parsed_line[2].strip) } if parsed_line
  end

  TRUE_VALUES = ['true', 'yes', 'on']

  def type_cast_value(value)
    if value =~ /true|false|on|off|yes|no/
      TRUE_VALUES.include?(value)
    elsif value =~ /^[0-9]+$/
      value.to_i
    elsif value =~ /^[0-9\.]+$/
      value.to_f
    else
      value
    end
  end
end

puts Config.new.parse
