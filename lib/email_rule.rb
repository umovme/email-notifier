# encoding: UTF-8
class EmailRule

  def initialize
    
  end

  attr_reader :validation_index, :to_index, :subject_index, :body_index, :cc_index
  attr_reader :to, :subject, :body, :cc
  
  attr_writer :validation_index, :to_index, :subject_index, :body_index, :cc_index
  attr_writer :to, :subject, :body, :cc

end