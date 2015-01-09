class Mission < ActiveRecord::Base
  validates :status,
    :inclusion  => { :in => [ 'pending', 'active', 'completed', 'failed' ],
    :message    => "%{value} is not a valid mission status" }
  validates :description, presence: true
  validates :code_name, presence: true, uniqueness: true
  
  belongs_to :agent
  
  def self.active
    Mission.where(status: :active)
  end
  
  def active?
    if status == "active"
      true
    else
      false
    end
  end
end
