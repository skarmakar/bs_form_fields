require_relative "bs_form_fields/version"
require_relative "bs_form_fields/bootstrap_five"
require_relative "bs_form_fields/form_builder_extension"

module BsFormFields
  class << self
    attr_accessor :renderer

    def renderer_class
      @renderer_class ||= "BsFormFields::#{renderer.to_s.classify}".constantize
    end
  end
end
