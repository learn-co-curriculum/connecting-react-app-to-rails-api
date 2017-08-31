class Campaign < ApplicationRecord
    validates :title, :description, :goal, :pledged, presence: true
end
