class BlogPost < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content
  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :content, presence: true

  # scope :sorted, -> { order(Arel.sql("published_at DESC NULLS FIRST")).order(updated_at: :desc) } --> another option how to ensure sorting
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
