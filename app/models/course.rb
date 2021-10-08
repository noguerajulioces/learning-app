class Course < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, length: {minimum:10, maximum:100}
   
    def to_s
        title
    end
end
