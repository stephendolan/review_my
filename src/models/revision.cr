class Revision < BaseModel
  table do
    belongs_to snippet : Snippet
    column content : String
    column creator_name : String?
    belongs_to creator : User?
  end
end
