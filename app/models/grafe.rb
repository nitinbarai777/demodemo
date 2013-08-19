class Grafe < ActiveRecord::Base
  belongs_to :cemetery
  belongs_to :area
  belongs_to :section
  belongs_to :row
  belongs_to :plot
  belongs_to :grave_status
  belongs_to :monument
  belongs_to :unit_type
  has_many :grantee_graves, :dependent => :destroy
  has_many :bookings
  belongs_to :stone_mason, class_name: 'User'
  
  validates :grave_number, :presence => true
  
  include SearchHandler
  
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader
  
  scope :active, -> {where(:is_active => true)}
  
  scope :in_cemetery, -> {where("area_id IS NULL and section_id IS NULL and row_id IS NULL and plot_id IS NULL")}  
end