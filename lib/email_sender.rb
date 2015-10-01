require 'rubygems'
require 'pony'
require 'yaml'

class EmailSender


	def initialize(pony)
		@pony = Pony
	end

	def load_options
		YAML.load_file(File.join(File.dirname(__FILE__), '../conf/email_options.yml'))
	end
	
	def get_settings 
		options = load_options
		@pony.options = {:via => :smtp, :via_options => {
			:address => options['config']['address'],
			:port => options['config']['port'],
			:enable_starttls_auto => options['config']['enable_starttls_auto'],
			:user_name => options['config']['user_name'],
			:password => options['config']['password'],
			:authentication => :plain,
			:domain => options['config']['domain']
		}}
	end

	def send email_rule
		get_settings
		begin
		 @pony.mail(:to => email_rule.to_index,
		 	:subject => email_rule.subject_index ,
		 	:body => email_rule.body_index,
		 	:cc =>email_rule.to_index)
		 puts email_rule.to_index + 'Email enviado com sucesso!'
		rescue Exception=>e
			puts e
		end
	end
end