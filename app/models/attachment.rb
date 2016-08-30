# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attachment < ApplicationRecord

  mount_uploader :file, FileUploader

end
