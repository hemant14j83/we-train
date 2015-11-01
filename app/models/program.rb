class Program < ActiveRecord::Base
  #default_scope { where status: 'active' }
  belongs_to :recruiter, inverse_of: :programs
  has_many :savedprograms, :dependent => :destroy
  has_many :categories, as: :catable


  scope :by_status, -> status { where(status: status) }
  scope :recent, -> {order("programs.created_at DESC")}

  validates :name, :program_details, :duration, :payment_detail, :city, :presence => true #, :venue, :state
  validates :payment_detail, length:{in: 1..5}
  validates :payment_detail, :numericality =>  {:only_integer=>true, :message => ' is invalid.'}
  validates :duration, length:{in: 1..2}
  validates :duration, :numericality =>  {:only_integer=>true, :message => ' is invalid.'}

  def validstartdate?
  	self.start_date.to_date >= Date.today
  end
end
