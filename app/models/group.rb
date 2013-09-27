class Group < ActiveRecord::Base
  default_scope { order(:name) }

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
