class EmailRuleFixture

	def self.with_indexes_populated indexes
		email_rule = EmailRule.new
		email_rule.to_index = indexes[0]
		email_rule.cc_index = indexes[1]
		email_rule.subject_index = indexes[2]
		email_rule.body_index = indexes[3]
		email_rule.condition_index = indexes[4]
		email_rule
	end

	def self.build_email_rule 
		email_rule = EmailRule.new
		email_rule.to = "gelias@umov.me"
		email_rule.cc = "guilherme.elias@gmail.com"
		email_rule.subject = "Teste"
		email_rule.body = "Corpo do email de teste unitario envio de email"
		email_rule
	end

	def self.with_no_to_index
		email_rule = EmailRule.new
		email_rule.to_index = ''
		email_rule
	end

	def self.with_no_subject_index
		email_rule = EmailRule.new
		email_rule.subject_index = ''
		email_rule
	end

	def self.with_to_and_subject_indexes
		email_rule = EmailRule.new
		email_rule.to_index = "1"
		email_rule.subject_index = '2'
		email_rule
	end

	def self.with_condition value
		email_rule = EmailRule.new
		email_rule.condition = value
		email_rule
	end

	def self.with_to value
		email_rule = EmailRule.new
		email_rule.to = value
		email_rule
	end

	def self.with_subject value
		email_rule = EmailRule.new
		email_rule.subject = value
		email_rule
	end

end