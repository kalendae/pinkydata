module Koala
  module Facebook
    module GraphAPIMethods
      def get_local_picture(object, args = {})
        "https://#{GRAPH_SERVER}/#{object}/picture?#{args.to_query}"
      end
    end
  end
end