class Word 
  include Neo4j::ActiveNode
  property :name, type: String

  def self.find_path(source, target)
    source_word =  Word.find_by(name: source)
    target_word =  Word.find_by(name: target)

    path_source_to_target = Neo4j::Session.query("MATCH p=SHORTESTPATH((a{name:'#{source_word}'})--(b{name:'#{target_word}'})) RETURN extract(n IN nodes(p)| n.name) AS extracted")
    # what is the type of the object returned above
    # how to get it down to array of word names?
    return path_source_to_target.each.each.each.class
  end
end
