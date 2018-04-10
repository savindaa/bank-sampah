module ValidatePhoneNumberUniquenessAcrossModels
    extend ActiveSupport::Concern

    @@included_classes = []

    included do
        @@included_classes << self
        validate :phone_number_unique_across_all_models
    end

    private

    def phone_number_unique_across_all_models
        return if self.phone_number.blank?
        @@included_classes.each do |klass|
            scope = klass.where(phone_number: self.phone_number)
            if self.persisted? && klass == self.class
                scope = scope.where('id != ?', self.id)
            end
            if scope.any?
                self.errors.add :phone_number, 'is already taken'
                break
            end
        end
    end
end