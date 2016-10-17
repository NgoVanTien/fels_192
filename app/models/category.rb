class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  scope :update_desc,->{order updated_at: :desc}
  scope :search,->(search){where("name LIKE ?", "%#{search}%").update_desc}

  has_attached_file :category_img, styles: {category_index: "250x200",
    category_show: "400x350" }, default_url: "/images/:style/missing.png"

  validates :name, presence: true, length: {maximum: 140}
  validates_attachment_content_type :category_img, content_type: /\Aimage\/.*\z/

  def any_words_inside?
    self.words.any?
  end
end
