require 'email_sender'

RSpec.describe EmailSender, "#Send Email" do
	
	context "when I get to send email_roule" do
		
		it "load email options" do
			email_sender = EmailSender.new
			options = email_sender.load_options
			#options["config"].index["address"].exists
			expect(options["config"]["address"]).to exist
			expect(options.length).to eq(1)
		end

	end

end