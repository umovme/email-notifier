require 'email_notifier'

RSpec.describe EmailNotifier, "#Send Email" do
	
	context "with rules mapped into email rules" do
		
		it "load email rules" do
			email_notifier = EmailNotifier.new
			settings = email_notifier.load_email_rules_settings
			expect(settings.length).to eq(4)
		end

	end

end