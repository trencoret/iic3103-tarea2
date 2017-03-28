class Usuario < ActiveRecord::Base
  validates :usuario, :nombre, presence:true
  attr_readonly :id
end
