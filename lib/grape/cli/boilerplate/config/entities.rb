module BOILERPLATE

  module Entities

    class Mongoid < Grape::Entity
			format_with(:mongo_id) { |id| id.to_s }
			with_options(format_with: :mongo_id) do
				expose :_id, as: :id
			end
			expose :created_at
			expose :updated_at
		end # class

		class MongoidBase < Grape::Entity
			format_with(:mongo_id) { |id| id.to_s }
			with_options(format_with: :mongo_id) do
				expose :_id, as: :id
			end
		end

  end

end
