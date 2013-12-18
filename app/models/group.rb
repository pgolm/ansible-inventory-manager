class Group < ActiveRecord::Base
  include Variabable 
  default_scope { order(:name) }

  validates :name, presence: true, 
                   uniqueness: { scope: [:group_id, :inventory_id] }, 
                   exclusion: { in: %w( * all ) }
  validates :inventory_id, presence: true

  belongs_to :inventory

  has_many :group_host
	has_many :hosts, through: :group_host, source: :host

  def hosts=(host_ids)
    hosts.clear

    host_ids.each do |h|
      begin
        hosts << Host.find(h)
      rescue
      end
    end
  end
end
