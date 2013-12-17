class Inventory < ActiveRecord::Base
  include SecureKey
  
  before_create do
    self.key = Inventory::next_secure_key
  end

  default_scope { order(:name) }
  
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :owner, presence: true
  
  belongs_to :owner, foreign_key: :user_id, class_name: User
  has_many :groups, class_name: Group, dependent: :destroy
	has_many :hosts, class_name: Host, dependent: :destroy

  def as_ansible_ini
    result = ""

    self.hosts.find_each do |host|
      result += "#{ini_host_line(host)}\n"
    end

    self.groups.find_each do |group|
      result +=  "\n[#{group.name}]\n"
      group.hosts.find_each do |host|
        result += ini_host_line(host) + "\n"
      end

      if group.variables.size > 0
        result +=  "\n[#{group.name}:vars]\n"
        vars = ActiveSupport::JSON.decode(group.variables).map {|var| "#{var[0]}=#{var[1]}"}
        result += vars.join('\n')
      end
    end

    result
  end

  private 

  def ini_host_line(host)
    begin
      result = host.alias + ' '
      vars = ActiveSupport::JSON.decode(host.variables).map {|var| "#{var[0]}=#{var[1]}"}
      result += vars.join(' ')
    rescue
      "# Error with #{host}"
    end
  end
end
