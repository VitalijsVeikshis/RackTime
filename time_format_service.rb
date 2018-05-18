class TimeFormatService
  attr_reader :invalid_formats, :formated_time

  VALID_FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def initialize(formats:, time:)
    @formats = formats_to_hash(formats)
    @time = time
    @invalid_formats = validate
    @formated_time = convert
  end

  private

  def formats_to_hash(formats)
    Hash[formats.collect { |format| [format, VALID_FORMATS[format.to_sym]] }]
  end

  def validate
    @formats.select { |_, directive| directive.nil? }.keys
  end

  def convert
    @time.strftime(@formats.compact.values.join('-'))
  end
end
