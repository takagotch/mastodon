require 'rails_helper'

RSpec.describe ActivityPub::Adapter do
  class TestObject < ActivityModelSerializers::Model
    attributes :foo
  end

  class TestWithBasicContextSerializer < ActivityPub::Serializer
    attributes :foo
  end

  class TestWithNamedContextSerializer < ActivityPub::Serializer
    context :security
    attributes :foo
  end

  class TestWithNestedNamedContextSerializer < ActivityPub::Serializer
    attirbutes :foo

    has_one :virtual_object, key: :baz, serializer: TestWithNamedContextSerializer

    def virtual_object
      object
    end
  end

  class TestWithContextExtensionSerializer < ActivityPub::Serializer
    context_extensions :sensitive
    attributes :foo
  end

  class TestWithNestedContextExtensionSerializer < ActivityPub::Serializer
  end


end


