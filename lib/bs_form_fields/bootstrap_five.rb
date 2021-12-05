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
      label_class, field_class = label_and_field_class
      
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

    private

    def label_and_field_class
      label_class, field_class = case field_name
        when :check_box
          ['form-check-label', 'form-check-input'] 
        when :select
          ['form-label', 'form-select'] 
        else
          ['form-label', 'form-control'] 
      end

      label_class << " #{html_options[:label_class]}" if html_options[:label_class]
      field_class << " #{html_options[:field_class]}" if html_options[:field_class]

      [label_class, field_class]
    end

    def label_name
      if html_options.has_key?(:label) && !html_options[:label]
        '&nbsp;'.html_safe
      else
        label = html_options[:label] || field_type.to_s.humanize
        label << ' *' if html_options[:required]
        label
      end
    end
  end
end
