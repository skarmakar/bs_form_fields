require_relative 'bootstrap_five'

ActionView::Helpers::FormBuilder.class_eval do
  # simple helper to generate bootsrap 5 form fields
  def method_missing(*args)
    called_method_name = args.first.to_s
    options_for_select = nil

    if called_method_name.include?('bs_')
      if called_method_name.include?('select')
        method_name, field_type, options_for_select, options, html_options = args
      else
        method_name, field_type, html_options = args
      end

      BsFormFields.renderer_class.new(self, {
        method_name: method_name,
        field_type: field_type,
        options_for_select: options_for_select,
        options: options,
        html_options: html_options
      }).render
    else
      super
    end
  end

  def bs_submit_button(btn_text = 'Submit', options = {})
    css_class = 'btn '
    css_class << (options[:class] ? options[:class] : 'btn-primary')
    button btn_text, class: css_class
  end
end
