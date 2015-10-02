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
		emailRule = EmailRule.new
		emailRule.to = "to@umov.me"
		emailRule.cc = "cc@gmail.com"
		emailRule.subject = "Teste"
		emailRule.body = "Corpo do email de teste unitario envio de email"
		emailRule
	end

end