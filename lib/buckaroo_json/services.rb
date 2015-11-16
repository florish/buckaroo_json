module BuckarooJson
  module Services
    class << self
      def convert(services:)
        {
          'ServiceList' => services.map { |s| convert_service(s) }
        }
      end

      private

      def convert_service(params)
        base, others = split_hash(params, 'Name', 'Action', 'Version')
        base.merge('Parameters' => expand_parameters(others))
      end

      def split_hash(the_hash, *keys)
        selected = the_hash.select { |key, _| keys.include?(key) }
        others = the_hash.reject { |key, _| keys.include?(key) }
        [selected, others]
      end

      def expand_parameters(params)
        params.to_a.map do |key, value|
          { 'Name' => key, 'Value' => value }
        end
      end
    end
  end
end
