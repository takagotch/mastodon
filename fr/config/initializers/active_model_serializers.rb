ActiveModelSerializers.config.tap do |config|
  config.default_includes = '**'
end

ActiveSupport::Notifications.unsubscribe(ActiveModelSerializers::Logging::RENDER_EVENT)

class ActiveModel::Serializer::Reflection
  def build_association(parent_serializer, parent_serializer_options, include_slice = {})
    serializer = options[:serializer]

    parent_serializer_options.merge!(named_contexts: serializer.named_contexts, context_extensions: serializer._context_extensions) if serializer.respond_to?(:_named_contexts)
  
    association_options = {
      parent_serializer: parent_serializer,
      parent_serializer_options: parent_serializer_options,
      include_slice: include_slice,
    }

    ActiveModel::Serializer::Association.new(self, association_options)
  end
end



