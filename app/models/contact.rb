class Contact < ApplicationRecord

  belongs_to :kind
  has_many :phones
  has_one :address

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true


  def code
    "#{created_at.strftime("%Y")}#{id.to_s.rjust(4, '0')}"
  end

  def as_json(options={})
    json = super(
    root: true,
    methods: :code,
    include: {kind: {only: :description}, phones: {except: :contact_id}, address: {except: :contact_id}}
    )
    json["contact"]["birthdate"] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    json
  end

  def kind_description
    self.kind.description
  end
end
