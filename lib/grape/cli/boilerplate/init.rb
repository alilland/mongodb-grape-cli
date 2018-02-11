module BOILERPLATE

  require './settings.rb'

	## Configuration
	Dir.glob('./config/*.rb') { |file| load file }

	## Library
	Dir.glob('./lib/*.rb') { |file| load file }

	## Import models
	Dir.glob('./models/*.rb') { |file| load file }

	## Import entities
	Dir.glob('./entities/*.rb') { |file| load file }


  ## Entity for API error responses
	module ErrorFormatter
		def self.call(message, backtrace, options, env)
			if message.is_a? String
				{ status: 'error', error: message }.to_json
			elsif message.is_a? Hash
				status = { status: 'error' }
				(status.merge(message)).to_json
			end
		end
	end

  class API < Grape::API
    use Rack::JSONP
		content_type :json, 'application/json'
		default_format :json

    log_file = File.open('./log/logfile.log', 'a')
    log_file.sync = true
    logger Logger.new GrapeLogging::MultiIO.new(STDOUT, log_file)
    use GrapeLogging::Middleware::RequestLogger,
      logger: logger,
      include: [ GrapeLogging::Loggers::RequestHeaders.new ]

		error_formatter :json, -> (message, backtrace, options, env, original_exception) {
			message = { error_message: message } if message.is_a? String
			{ status: 'ERROR', error: message }.to_json
		}

    rescue_from :all

		## Mongoid validation errors
		rescue_from Mongoid::Errors::Validations do |e|
			error!({ error_message: "The #{ e.document.class.to_s } could not be saved.", model_validations: e.document.errors.messages }, 500)
		end

		## Grape validation errors
		rescue_from Grape::Exceptions::ValidationErrors do |e|
			error!({ error_message: "Invalid payload. #{ e.message.capitalize }.", resource_validations: e }, 400)
		end

		helpers do
      def present_pagination(data, **params)
        pagination = {
          page: params[:page] ||= 1,
          per_page: params[:per] ||= 10,
          page_count: data.total_pages
        }
        present pagination, root: 'pagination', with: Grape::Presenters::Presenter
      end

      def present_data(key, data, options = {})
        response = {}
        d = (data.class.respond_to? :count) ? [data] : data
        d = [] if d.nil?
        response[key] = options[:with].represent(d, options.except(:with))
        present response, options, root: "data", with: Grape::Presenters::Presenter
      end

			def present_meta(data)
				d = (data.class.respond_to? :count) ? [data] : data
        @http_status = Rack::Utils::HTTP_STATUS_CODES[status]
        @record_count = d.nil? ? 0 : d.size
        @response_time = Time.now - @start_time
				meta = {
				  status: @http_status,
				  method: @method,
				  record_count: @record_count,
				  response_time: @response_time
				}
				present meta, with: Grape::Presenters::Presenter
			end

			def sanitize_user_input(user_input)
				unless user_input.nil?
					input = user_input.is_a?(String) ? user_input.strip : user_input
					Sanitize.fragment(input, Sanitize::Config::RESTRICTED)
				end
			end

      def logger
		    API.logger
		  end
    end

		before do
			@start_time = Time.new
	  	@access_key = nil
      @method = request.request_method
		end

    get '/' do
      present :api, {message: 'successfully launched api'}, with: Grape::Presenters::Presenter
    end

	  Dir.glob('./resources/*.rb') { |file| load file }
    # mount BOILERPLATE::Resources::Auth

  end

end
