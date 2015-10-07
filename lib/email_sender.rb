require 'rubygems'
require 'pony'
require 'yaml'
require 'logging'
require_relative 'email_rule'

class EmailSender

	def initialize
    	@logger = Logging.logger('log/notifier.log')
    	@logger.level = :info
  	end

	def load_options
		YAML.load_file(File.join(File.dirname(__FILE__), '../conf/email_options.yml'))
	end
	
	def get_settings 
		options = load_options
		Pony.options = {:via => :smtp, :via_options => {
			:address => options['config']['address'],
			:port => options['config']['port'],
			:enable_starttls_auto => options['config']['enable_starttls_auto'],
			:user_name => options['config']['user_name'],
			:password => options['config']['password'],
			:authentication => :plain,
			:domain => options['config']['domain']
		}}
	end

	def send? email_rule, mail_handler = Pony
		get_settings
		begin
		@logger.info "Enviando e-mail: #{email_rule.inspect}"
		 mail_handler.mail(:to => email_rule.to,
		 	:subject => email_rule.subject ,
		 	:body => email_rule.body,
		 	:cc =>email_rule.cc)
		 @logger.info "Email enviado com sucesso para #{email_rule.to}"
		 true
		rescue Exception=> e
			@logger.error e
			false
		end
	end
end