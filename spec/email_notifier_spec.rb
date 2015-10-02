require 'email_notifier'

RSpec.describe EmailNotifier, "#Send Email" do

	context "Loading settings ..." do
		it " of email rules" do
			email_notifier = EmailNotifier.new
			settings = email_notifier.load_email_rules_settings
			expect(settings.length).to eq(4)
		end
	end
	
	context "Reading CSV file ..." do
		
		it "should check that a specific line isn't the first line!" do
			email_notifier = EmailNotifier.new
			is_first_line = email_notifier.is_first_line 2
			expect(is_first_line).to be false
		end

		it "should check that a specific line isn't the first line!" do
			email_notifier = EmailNotifier.new
			is_first_line = email_notifier.is_first_line 1
			expect(is_first_line).to be true
		end

		it "should check that a specific line isn't the second line!" do
			email_notifier = EmailNotifier.new
			is_second_line = email_notifier.is_second_line 1
			expect(is_second_line).to be false
		end

		it "should check that a specific line is the second line!" do
			email_notifier = EmailNotifier.new
			is_second_line = email_notifier.is_second_line 2
			expect(is_second_line).to be true
		end

	end

	context "Interpreting header file ..." do

		it "loading header mapping the rules and fields" do
			email_notifier = EmailNotifier.new
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body"
			#email_notifier.process_rules data_line, []
		end

	end

end