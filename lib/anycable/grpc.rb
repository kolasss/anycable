# frozen_string_literal: true

# require "grpc"
require 'grpc_kit'

module AnyCable
  module GRPC
  end
end

require "anycable/grpc/config"
require "anycable/grpc/server"

AnyCable.server_builder = ->(config) {
  AnyCable.logger.info "GrpcKit version: #{::GrpcKit::VERSION}"

  ::GRPC.define_singleton_method(:logger) { AnyCable.logger } if config.log_grpc?
  GrpcKit.logger = AnyCable.logger if config.log_grpc?

  params = config.to_grpc_params

  AnyCable::GRPC::Server.new(**params, host: config.rpc_host)
}
