module Fog
  module AWS
    class ELBV2 < ELB
      request_path 'fog/aws/requests/elbv2'
      request :add_tags
      request :describe_tags
      request :remove_tags
      request :describe_load_balancers
      request :describe_listeners

      class Real < ELB::Real
        def initialize(options={})
          @version = '2015-12-01'

          super(options)
        end
      end
    end
  end
end
