class Project < ApplicationRecord
  acts_as_paranoid
  enum genre: %i[pre_sale after_sale]
  enum status: %i[approving correction doing done close]

  belongs_to :user
  belongs_to :customer
  has_many :satisfactions
  has_many :project_users, dependent => destroy
  has_many :tech_hours, dependent => destroy
  has_many :project_passs, dependent => destroy
  has_many :documents
  has_and_belongs_to_many :customer_contacts
  accepts_nested_attributes_for :customer
  

  scope :mine, -> (user_id) { where(user_id: user_id) }
  scope :approving, -> { where(status: [:approving, :correction]) }
  scope :closed, -> { where(status: :close) }
  scope :todo, -> (user_id) { where(auditor: user_id, status: :approving) }

  after_create :generate_number
  before_save :update_done_at, :update_approved_at

  def update_done_at
    self.done_at = Time.zone.now if self.status == "done" and self.status_was != "done"
  end

  def update_approved_at
    self.approved_at = Time.zone.now if self.status == "doing" and self.status_was != "doing"
  end

  def generate_number
    number = "RS%05d" % self.id
    self.update(number: number)
  end

end
