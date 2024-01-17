class Contact < ApplicationRecord

  belongs_to :kind

  def code
    "#{created_at.strftime("%Y")}#{id.to_s.rjust(4, '0')}"
  end

  def as_json(options={})
    super(except: [:id],
    methods: :code,
    include: {kind: {only: :description}}
    )
  end

  def kind_description
    self.kind.description
  end
end
