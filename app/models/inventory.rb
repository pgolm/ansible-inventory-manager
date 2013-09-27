class Inventory < ActiveRecord::Base
  default_scope { order(:name) }

  has_many :groups, class_name: Group, dependent: :destroy
	has_many :hosts, class_name: Host, dependent: :destroy

  def as_ansible
    result = {}

    result['all'] = hosts.map(&:alias)

    groups.find_each do |group|
      result[group.name] = {}
      result[group.name]['hosts'] = group.hosts.map(&:alias)
      result[group.name]['vars'] = ActiveSupport::JSON.decode(group.variables)
    end

    result['_meta'] = {}
    result['_meta']['hostvars'] = {}

    hosts.find_each do |host|
      result['_meta']['hostvars'][host.alias] = ActiveSupport::JSON.decode(host.variables)
    end

    result
  end
end
