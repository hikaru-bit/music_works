class Post < ApplicationRecord

  belongs_to :user

  enum is_recruitment:[:加入案件, :募集案件]
  enum is_online:[:可能, :不可]
  enum period:[:期間の定めなし, :一ヶ月以内, :三ヶ月以内, :六ヶ月以内]
  enum guarantee:[:なし, :あり]

end
