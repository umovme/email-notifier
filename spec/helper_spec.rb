require 'rubygems'
require 'helper'

RSpec.describe Helper, "Helps stuff" do
	
	describe "compare CSV's column with email rule field" do
		
		it "should don't match column when email rule is blank" do
			column = "rule1_to"
			email_rule_to = ""
			expect(Helper.is_column_match email_rule_to, column).to be false
		end

		it "should don't match column when email rule is nil" do
			column = "rule1_to"
			email_rule_to = nil
			expect(Helper.is_column_match email_rule_to, column).to be false
		end

		it "should don't match column when column is empty" do
			column = ""
			email_rule_to = "rule1_to"
			expect(Helper.is_column_match email_rule_to, column).to be false
		end

		it "should don't match column when column is nil" do
			column = nil
			email_rule_to = "rule1_to"
			expect(Helper.is_column_match email_rule_to, column).to be false
		end

		it "should don't match column when email rule is different" do
			column = "rule2_to"
			email_rule_to = "rule1_to"
			expect(Helper.is_column_match email_rule_to, column).to be false
		end

		it "should don't match column when email rule is different" do
			column = "rule2_to"
			email_rule_to = "rule1_to"
			expect(Helper.is_column_match email_rule_to, column).to be false
		end

		it "should match column when email rule and column are equals" do
			column = "rule1_to"
			email_rule_to = "rule1_to"
			expect(Helper.is_column_match email_rule_to, column).to be true
		end

	end

end
