require_relative 'time_format_service'

class App
  def call(env)
    req = Rack::Request.new(env)

    case req.path_info
    when /time/
      response(req)
    else
      [404, headers, ['Wrong path']]
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(req)
    format_service = TimeFormatService.new(
      formats: req.params['format'].split(','),
      time: Time.now
    )
    invalid_formats = format_service.invalid_formats

    if invalid_formats.empty?
      [200, headers, [format_service.formated_time]]
    else
      [400, headers, ["Unknown time format [#{invalid_formats.join(', ')}]"]]
    end
  end
end
