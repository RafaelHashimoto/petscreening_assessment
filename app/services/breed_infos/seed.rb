module BreedInfos
  class Seed
    class << self
      def insert_all
        BreedInfo.upsert_all(breed_infos_attributes, unique_by: :name)
      end

      private

      def breed_infos_attributes
        dog_api_breeds.map do |breed|
          {
            name:                 breed['attributes']['name'],
            description:          breed['attributes']['description'],
            max_life_expectancy:  breed['attributes']['life']['max'],
            male_max_weight:      breed['attributes']['male_weight']['max'],
            male_min_weight:      breed['attributes']['male_weight']['min'],
            female_max_weight:    breed['attributes']['female_weight']['max'],
            female_min_weight:    breed['attributes']['female_weight']['min'],
            hypoallergenic:       breed['attributes']['hypoallergenic']
          }
        end
      end

      def dog_api_breeds
        DogApi::Breeds.fetch_all
      end
    end
  end
end
