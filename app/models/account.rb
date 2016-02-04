class Account < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  validates :subdomain, presence: true, uniqueness: true
  accepts_nested_attributes_for :owner
end
