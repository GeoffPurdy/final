class Word 
  include Neo4j::ActiveNode
  property :name, type: String

  def self.find_path(source, target)
    source_word =  Word.find_by(name: source).name
    target_word =  Word.find_by(name: target).name

    # FIXME this is a Cypher injection risk
    path_source_to_target = Neo4j::Session.query("MATCH p=SHORTESTPATH((a{name:'#{source_word}'})--(b{name:'#{target_word}'})) RETURN extract(n IN nodes(p)| n.name) AS extracted")
    # what is the type of the object returned above
    # how to get it down to array of word names?
    return path_source_to_target.to_a
  end

  def self.random_pair(length)
    random_path = []

    while( random_path.none? ) do
      source_word = Neo4j::Session.query("MATCH (n) WITH n, rand() AS r WHERE length(n.name) = #{length} RETURN n.name AS word ORDER BY r LIMIT 1").first['word']
      target_word = Neo4j::Session.query("MATCH (n) WITH n, rand() AS r WHERE length(n.name) = #{length} RETURN n.name AS word ORDER BY r LIMIT 1").first['word']

      random_path = Neo4j::Session.query("MATCH p=SHORTESTPATH((a{name:'#{source_word}'})--(b{name:'#{target_word}'})) RETURN extract(n IN nodes(p)| n.name) AS extracted")
    end

    return random_path.to_a
  end
end
