class Snippet < BaseModel
  table do
    column slug : String
    column title : String
    column content : String
    belongs_to creator : User
  end
end
