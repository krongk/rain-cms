class Admin::Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
end
