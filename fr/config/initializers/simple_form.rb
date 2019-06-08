
module AppendComponent
  def append(wrapper_options = nil)
    @append ||= begin
      options[:append].to_s.html_safe if options[:append].present?
    end
  end
end

module RecommendedComponent
  def recommended(wrapper_options = nil)
    return unless options[:recommended]
    options[:label_text] = ->(raw_label_text, _required_label_text, _label_present) { safe_join([raw_label_text, ' ', content_tag(:span, content_tag(:span, I18n.t('simple_form.recommended'), class: 'recommended'))]) }
    nil
  end
end

SimpleForm.include_component(AppendComponent)
SimpleForm.include_component(RecommendedComponent)

SimpleForm.setup do |config|
  config.wrappers :default, class: :input, hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    b.use :html5

    b.use :placeholder

    b.optional :maxlength

    b.optional :pattern

    b.optional :min_max

    b.optional :readonly

    b.use :input
    b.use :hint, wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }

  end

  config.wrappers :with_label, class: [], hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    b.use :html5
    b.use :label_input, wrap_with: { tag: :div, class: :label_input }
    b.use :hint, wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.wrappers :with_label, class: [:input, :with_block_label], hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    b.use :html5
    b.use :label
    b.use :hint, wrap_with: { tag: :span, class: :hint }
    b.use :input,
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.default_wrapper = default

  config.boolean_style = :nested

  config.button_class = 'error_notification'


end


