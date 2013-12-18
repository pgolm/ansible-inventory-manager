class Host < ActiveRecord::Base
  include Variabable 
  default_scope { order(:alias) }

  validates :alias, presence: true, uniqueness: { scope: :inventory_id } 
  validates :inventory_id, presence: true 
  validates :variables, json: true

  belongs_to :inventory

  has_many :group_host
  has_many :groups, through: :group_host, source: :group
  
  def groups=(group_ids)
    groups.clear

    group_ids.each do |g|
      begin
        groups << Group.find(g)
      rescue
      end
    end
  end
end
