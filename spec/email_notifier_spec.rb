require 'email_notifier'
require_relative './fixture/email_rule_fixture'

RSpec.describe EmailNotifier, "#Send Email" do

	context "Loading settings" do
		it "of email rules" do
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
		it "should build invalidate email rules with no required fileds fullfilled" do
			header = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_condition"
			rules_mapped_by_index = @email_notifier.load_email_rules header, @email_notifier.load_email_rules_settings
			expect(rules_mapped_by_index.length).to eq(1)
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

		it "should load 'SUBJECT' content ..." do
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_body"
			email_list = @email_notifier.build_emails(data_line, @rules)
			expect(email_list[0].cc).to eq('rule1_cc')
		end

		it "should load 'BODY' content ..." do
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_body"
			email_list = @email_notifier.build_emails(data_line, @rules)
			expect(email_list[0].body).to eq('rule1_body')
		end

		it "should load 'CC' content ..." do
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_body"
			email_list = @email_notifier.build_emails(data_line, @rules)
			expect(email_list[0].cc).to eq('rule1_cc')
		end

		it "should load 'CONDITION' content ..." do
			data_line = "rule1_to;rule1_cc;rule1_subject;rule1_body;rule1_condition"
			email_list = @email_notifier.build_emails(data_line, @rules)
			expect(email_list[0].condition).to eq('rule1_condition')
		end

	end

	context "should validate required fields for an email rule" do
		
		before :each do
		  @email_notifier = EmailNotifier.new
		end		
		
		it "should invalidate email_rule once there is no TO" do
			rule_with_no_to = EmailRuleFixture.with_no_to
			valid_email_rule = @email_notifier.validate_email_rule rule_with_no_to
			expect(valid_email_rule).to be false
		end

		it "should invalidate email_rule once there is no SUBJECT" do
			rule_with_no_subject = EmailRuleFixture.with_no_subject
			valid_email_rule = @email_notifier.validate_email_rule rule_with_no_subject
			expect(valid_email_rule).to be false
		end

		it "should validate email_rule once having required fields(TO, SUBJECT)" do
			rule_with_valid_rule = EmailRuleFixture.with_to_and_subject
			valid_email_rule = @email_notifier.validate_email_rule rule_with_valid_rule
			expect(valid_email_rule).to be true
		end

	end

end