class Rule < ActiveRecord::Base
  validate :has_one_entry

  def has_one_entry
    errors.add(:base, 'must enter at least one category') if self.name.blank? && self.email.blank? && self.company.blank?
  end
end
