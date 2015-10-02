require 'rubygems'
require 'email_sender'

RSpec.describe EmailSender, "#Send Email" do
	
	describe "when I get to send email_roule" do

		before :all do
			@pony = double('pony')
			@email_sender = EmailSender.new @pony
		end
		
		it "load email options" do
			options = @email_sender.load_options
			expect(options["config"].keys.include?('address')).to be true
			expect(options["config"].keys.include?('port')).to be true
			expect(options["config"].keys.include?('enable_starttls_auto')).to be true
			expect(options["config"].keys.include?('user_name')).to be true
			expect(options["config"].keys.include?('password')).to be true
			expect(options["config"].keys.include?('domain')).to be true
			expect(options.length).to eq(1)
		end

		it "Should raise an error when send email" do

		end

	end

end