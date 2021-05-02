# frozen_string_literal: true

class ApplicationService
  # CF https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
  def self.call(*args, &block)
    new(*args, &block).send(:call)
  end

  def self.method_missing(method_name, *args, &block)
    return super unless respond_to_missing?(method_name)

    new.send(method_name.to_sym, *args, &block)
  end

  def self.respond_to_missing?(method_name, include_private = false)
    method_name.to_sym.in?(public_instance_methods(false)) || super
  end
end
