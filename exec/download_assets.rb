# Downloads all assets
# Usage: run this from the top dir of this repo
# `ruby utils/download_assets.rb`
require 'open-uri'

assets = <<-ASSETS
  https://assets-origin.preview.alphagov.co.uk/government/assets/frontend/base-a27f2c4627a9b3dab6c58e7541cac5f22dd51e8af605a9309a5bf3deba357dc3.css
  https://assets-origin.preview.alphagov.co.uk/government/assets/frontend/print-4360a9429a952b5cc2857c5d805596be61c00b9563a96081ac5f9c1bdcec09d1.css
  https://assets-origin.preview.alphagov.co.uk/government/assets/frontend/base-ie6-d6321525941a35c17b1aed6f912b5ac270ffdddc954c7fe767030c9e77d1f52b.css
  https://assets-origin.preview.alphagov.co.uk/government/assets/frontend/base-ie7-ee70a6ba263cfe3ce08b722fa00067ce8eb5301621c5a9de962fa1298e559af3.css
  https://assets-origin.preview.alphagov.co.uk/government/assets/frontend/base-ie8-ec15bd081a8ebaf2bb5f17dbf4968a3e4020e8d6cd62f0106e5aae06c7e60b15.css
  https://assets-origin.preview.alphagov.co.uk/government/assets/frontend/base-ie9-7a768893fa763807de180d5d7b7c1f6d9208949aab43d447100c6b6d528dfb14.css
  https://assets-origin.preview.alphagov.co.uk/government/assets/application-951faf7db302d6ef9a52c9a028d24721c4a4e7090913e252941de8db2d16534c.js
ASSETS

assets.split("\n").map(&:strip).each do |asset_url|
  `cd assets && wget #{asset_url} --no-check-certificate`
end
