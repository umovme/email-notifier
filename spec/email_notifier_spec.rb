require 'email_notifier'
require_relative './fixture/email_rule_fixture'

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

	context "Reading header ..." do

		before :each do
		  @email_notifier = EmailNotifier.new
		end

		it "should build email rules based on header line ... " do
			header = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_condition"
			rules_mapped_by_index = @email_notifier.load_email_rules header, @email_notifier.load_email_rules_settings
			expect(rules_mapped_by_index[0].body_index).to eq(3)

		end
	end

	context "Building emails to be send ..." do

		before :each do
		  @email_notifier = EmailNotifier.new
		  @rules = [EmailRuleFixture.with_indexes_populated([0,1,2,3,4])]
		end

		it "should load 'TO' content ..." do
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_body"
			populated_email_list = @email_notifier.build_emails(data_line, @rules)
			expect(populated_email_list[0].to).to eq('rule1_to')
		end

		it "should load 'TO' content ..." do
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_body"
			email_list = @email_notifier.build_emails(data_line, @rules)
			expect(email_list[0].cc).to eq('rule1_cc')
		end

	end

	#map_email_rule

end