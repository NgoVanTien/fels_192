class Word < ApplicationRecord
  belongs_to :category
  has_many :lessons, through: :result
  has_many :results
  has_many :answers, dependent: :destroy, inverse_of: :word

  scope :order_name, ->{order :name}
  scope :of_category, ->category_id {where category_id: category_id}
  scope :search_name, ->search do
    where("name LIKE ?", "%#{search}%") if search.present?
  end
  scope :random, -> do
    order("RANDOM()").limit Settings.per_lesson.words
  end

  validates :name, presence: true, length: {maximum: 140}
  validates :content, presence: true
  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|attribute| attribute[:answer_content].blank?}
end
