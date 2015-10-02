# encoding: UTF-8
class EmailRule

  def initialize
    
  end

  attr_accessor :to, :subject, :body, :cc, :condition
  attr_accessor :condition_index, :to_index, :subject_index, :body_index, :cc_index

end