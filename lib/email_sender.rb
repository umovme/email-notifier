require 'rubygems'
require 'pony'
require 'yaml'

class EmailSender


	def load_options
		YAML.load_file(File.join(File.dirname(__FILE__), '../conf/email_options.yml'))
	end
	
	def get_settings _to
		options = load_options
		Pony.options = {:via => :smtp, :to => _to, :via_options => {
			:address => options['address'],
			:port => options['port'],
			:enable_starttls_auto => options['enable_starttls_auto'],
			:user_name => options['user_name'],
			:password => options['password'],
			:authentication => :plain,
			:domain => options['domain']
		}}
	end

	def send to, subject, body
		get_settings(to)
		begin
		 Pony.mail(:subject => subject ,:body => body)
		 puts 'Email enviado com sucesso!'
		rescue Exception=>e
			puts e
		end
	end
end