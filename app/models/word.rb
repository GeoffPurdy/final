class Word 
  include Neo4j::ActiveNode
  property :name, type: String

  def find_path(other)
    Neo4j::Session.query("MATCH p=SHORTESTPATH((a{name:'#{self.name}'})--(b{name:'#{other}'})) RETURN extract(n IN nodes(p)| n.name) AS extracted")
  end

end
