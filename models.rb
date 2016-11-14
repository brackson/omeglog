class Log < ActiveRecord::Base
  has_many :reports
  validates_uniqueness_of :url
end

class Report < ActiveRecord::Base
  belongs_to :log
end
