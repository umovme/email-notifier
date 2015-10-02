# encoding: UTF-8
class EmailRule

  def initialize
    
  end

  attr_reader :to, :subject, :body, :cc, :condition
  attr_writer :to, :subject, :body, :cc, :condition

  attr_reader :condition_index, :to_index, :subject_index, :body_index, :cc_index
  attr_writer :condition_index, :to_index, :subject_index, :body_index, :cc_index
  

end