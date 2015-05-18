require 'rails_helper'

RSpec.describe Podcast, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: podcasts
#
#  id          :integer          not null, primary key
#  title       :string
#  link        :string
#  language    :string           default("en-us")
#  copyright   :string
#  subtitle    :string
#  author      :string
#  description :string
#  email       :string
#  image       :string
#  categories  :string           is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
