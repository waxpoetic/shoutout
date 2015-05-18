class Podcast < ActiveRecord::Base
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
