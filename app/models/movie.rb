class Movie < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]

  belongs_to :director

  pg_search_scope :search_by_title_and_synopsys,
                  against: %i[title synopsis],
                  associated_against: {
                    director: %i[first_name last_name]
                  },
                  using: { tsearch: { prefix: true } }
end
