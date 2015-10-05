require 'rubygems'
require 'email_sender'
require 'email_rule'
require_relative './fixture/email_rule_fixture'

RSpec.describe EmailSender, "#Send Email" do
	
	describe "when I get to send email_roule" do

		before :all do			
			@email_sender = EmailSender.new
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

		it "Should return true when send email" do
			pony = class_double('pony')
			expect(pony).to receive(:mail)
			expect(@email_sender.send?(EmailRuleFixture.build_email_rule , pony)).to eq(true)
		end

		it "Should return raise false when send email" do
			pony = class_double('pony')
			expect(pony).to receive(:mail).and_raise(Exception.new,'Expected exception')
			expect(@email_sender.send?(EmailRuleFixture.build_email_rule , pony)).to eq(false)
		end

	end

end


