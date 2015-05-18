class AttachmentInput < SimpleForm::Inputs::Base
  def input(name)
    builder.attachment_field name
  end
end
