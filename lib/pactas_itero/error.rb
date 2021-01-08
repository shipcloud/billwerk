module PactasItero
  # Custom error class for rescuing from all Pactas errors
  class Error < StandardError

    # Returns the appropriate PactasItero::Error sublcass based
    # on status and response message
    #
    # @param [Hash] response HTTP response
    # @return [PactasItero::Error]
    def self.from_response(response, url_prefix)
      status  = response.response_status
      body    = response.response_body
      headers = response.response_headers

      if klass =  case status
                  when 400      then PactasItero::BadRequest
                  when 401      then error_for_401(headers)
                  when 403      then error_for_403(body)
                  when 404      then PactasItero::NotFound
                  when 406      then PactasItero::NotAcceptable
                  when 409      then PactasItero::Conflict
                  when 415      then PactasItero::UnsupportedMediaType
                  when 422      then PactasItero::UnprocessableEntity
                  when 400..499 then PactasItero::ClientError
                  when 500      then PactasItero::InternalServerError
                  when 501      then PactasItero::NotImplemented
                  when 502      then PactasItero::BadGateway
                  when 503      then PactasItero::ServiceUnavailable
                  when 500..599 then PactasItero::ServerError
                  end
        klass.new(response, url_prefix)
      end
    end

    def initialize(response = nil, url_prefix = "")
      @response = response
      @url_prefix = url_prefix
      super(build_error_message)
    end

    # Returns most appropriate error for 401 HTTP status code
    # @private
    def self.error_for_401(headers)
      if PactasItero::OneTimePasswordRequired.required_header(headers)
        PactasItero::OneTimePasswordRequired
      else
        PactasItero::Unauthorized
      end
    end

    # Returns most appropriate error for 403 HTTP status code
    # @private
    def self.error_for_403(body)
      if body =~ /rate limit exceeded/i
        PactasItero::TooManyRequests
      elsif body =~ /login attempts exceeded/i
        PactasItero::TooManyLoginAttempts
      else
        PactasItero::Forbidden
      end
    end

    # Array of validation errors
    # @return [Array<Hash>] Error info
    def errors
      if data && data.is_a?(Hash)
        data[:errors] || []
      else
        []
      end
    end

    private

    def data
      @data ||=
        if (body = @response.response_body) && !body.empty?
          if body.is_a?(String) &&
              @response.response_headers &&
              @response.response_headers[:content_type].include?("json")

            Sawyer::Agent.serializer.decode(body)
          else
            body
          end
        end
    end

    def response_message
      case data
      when Hash
        data[:Message]
      when String
        data
      end
    end

    def response_error
      "Error: #{data[:error]}" if data.is_a?(Hash) && data[:error]
    end

    def response_error_summary
      return nil unless data.is_a?(Hash) && !Array(data[:errors]).empty?

      summary = "\nError summary:\n"
      summary << data[:errors].map do |hash|
        hash.map { |k,v| "  #{k}: #{v}" }
      end.join("\n")

      summary
    end

    def build_error_message
      return nil if @response.nil?

      request_hash = @response.response[:request]
      url = "#{@url_prefix[0..-2]}#{request_hash[:url_path]}"
      [
        request_hash[:method].upcase,
        "#{redact_url(url)}:",
        "#{@response.response_status} -",
        response_message,
        response_error,
        response_error_summary,
      ].compact.join(" ")
    end

    def redact_url(url_string)
      %w[client_secret access_token].each do |token|
        url_string.gsub!(/#{token}=\S+/, "#{token}=(redacted)") if url_string.include? token
      end
      url_string
    end
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when Pactas returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when Pactas returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when Pactas returns a 401 HTTP status code
  # and headers include "X-Pactas-OTP"
  class OneTimePasswordRequired < ClientError
    #@private
    OTP_DELIVERY_PATTERN = /required; (\w+)/i

    #@private
    def self.required_header(headers)
      OTP_DELIVERY_PATTERN.match headers['X-Pactas-OTP'].to_s
    end

    # Delivery method for the user's OTP
    #
    # @return [String]
    def password_delivery
      @password_delivery ||= delivery_method_from_header
    end

    private

    def delivery_method_from_header
      if match = self.class.required_header(@response.response_headers)
        match[1]
      end
    end
  end

  # Raised when Pactas returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when Pactas returns a 403 HTTP status code
  # and body matches 'rate limit exceeded'
  class TooManyRequests < Forbidden; end

  # Raised when Pactas returns a 403 HTTP status code
  # and body matches 'login attempts exceeded'
  class TooManyLoginAttempts < Forbidden; end

  # Raised when Pactas returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when Pactas returns a 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when Pactas returns a 409 HTTP status code
  class Conflict < ClientError; end

  # Raised when Pactas returns a 414 HTTP status code
  class UnsupportedMediaType < ClientError; end

  # Raised when Pactas returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when Pactas returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when Pactas returns a 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when Pactas returns a 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when Pactas returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end

  # Raised when client fails to provide valid Content-Type
  class MissingContentType < ArgumentError; end

  # Raised when a method requires an application client_id
  # and secret but none is provided
  class ApplicationCredentialsRequired < StandardError; end
end
