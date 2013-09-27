class GroupHost < ActiveRecord::Base
  belongs_to :host
  belongs_to :group
end
