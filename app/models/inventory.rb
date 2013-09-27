class Inventory < ActiveRecord::Base
  default_scope { order(:name) }

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

  def as_ansible_json
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
