class Savedprogram < ActiveRecord::Base
  belongs_to :program
  belongs_to :trainer
end
