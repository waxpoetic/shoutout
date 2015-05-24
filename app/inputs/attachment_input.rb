class AttachmentInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options={})
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.attachment_field(attribute_name, merged_input_options)
  end
end
