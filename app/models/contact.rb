class Contact < ApplicationRecord

  belongs_to :kind
  has_many :phones

  def code
    "#{created_at.strftime("%Y")}#{id.to_s.rjust(4, '0')}"
  end

  def as_json(options={})
    json = super(
    root: true,
    methods: :code,
    include: {kind: {only: :description}},
    include: {phones: {except: :contact_id, root: true}}
    )
    json["contact"]["birthdate"] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    json
  end

  def kind_description
    self.kind.description
  end
end
