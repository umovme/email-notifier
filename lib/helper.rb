class Helper

	def self.is_column_match email_rule_field, column_name
		 if(email_rule_field.to_s.empty?)
		 	return false
		 end

		 if(column_name.to_s.empty?)
		 	return false
		 end

		 if(column_name.to_s.upcase != email_rule_field.to_s.upcase)
		 	return false
		 end

		 true
	end
end