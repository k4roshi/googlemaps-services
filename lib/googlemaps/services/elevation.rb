require "googlemaps/services/util"


module GoogleMaps
  module Services

    class Elevation
      attr_accessor :client

      def initialize(client)
        self.client = client
      end

      def query(locations: [], path: nil, samples: 0)
        params = {}

        if path && locations
          raise StandardError, "Should not specify both path and locations."
        end

        if locations
          params["locations"] = Convert.shortest_path(locations)
        end

        if path
          if path.is_a? String
            path = "enc:#{path}"
          elsif path.is_a? Array
            path = Convert.shortest_path(path)
          else
            raise TypeError, "Path should be either a String or an Array."
          end

          params = { "path" => path, "samples" => samples }
        end

        self.client.get(url: "/maps/api/elevation/json", params: params)["results"]
      end
    end

  end
end
