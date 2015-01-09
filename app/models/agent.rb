class Agent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  
  has_one :mission
  
  def name
    first_name + ' ' + last_name
  end
  
  def self.on_assignment
    Agent.includes(:mission)
  end
  
  def self.not_on_assignment
    Agent.includes(:mission).where('missions.id' => nil)
  end
  
  def on_assignment?
    if mission.nil?
      false
    else
      true
    end
  end
end
