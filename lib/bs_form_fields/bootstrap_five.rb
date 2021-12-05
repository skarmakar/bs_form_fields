module BsFormFields
  class BootstrapFive
    attr_reader :form, :field_type, :options_for_select, :html_options, :field_name

    def initialize(form, options = {})
      @form = form
      options.each { |key, val| instance_variable_set("@#{key}", val) }
      @html_options ||= {}
      @field_name = @method_name.to_s.sub('bs_','').to_sym
    end

    def render
      case field_name
      when :check_box
        field_class = 'form-check-input'
        label_class = 'form-check-label'
      when :select
        field_class = 'form-select'
        label_class = 'form-label'
      else
        field_class = 'form-control'
        label_class = 'form-label'
      end

      label_name = html_options[:label] || field_type.to_s.humanize
      label_name << ' *' if html_options[:required]

      # form label
      label = form.send(:label, field_name, label_name, class: label_class)
      
      # form field
      field = if options_for_select
        form.send(field_name, field_type, options_for_select, options, html_options.merge(class: field_class))
      else
        form.send(field_name, field_type, html_options.merge(class: field_class))
      end

      wrapper_class = field_name == :check_box ? 'form-check' : 'mb-3'

      %{
        <div class="#{wrapper_class}">
          #{label}
          #{field}
        </div>
      }.html_safe
    end
  end
end
