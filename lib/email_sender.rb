require 'rubygems'
require 'pony'
require 'yaml'

class EmailSender


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
		 mail_handler.mail(:to => email_rule.to,
		 	:subject => email_rule.subject ,
		 	:body => email_rule.body,
		 	:cc =>email_rule.cc)
		 puts email_rule.to + ': Email enviado com sucesso!'
		 true
		rescue Exception=>e
			puts e
			false
		end
	end
end