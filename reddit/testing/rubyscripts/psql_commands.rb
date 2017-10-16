module Commands
  @@all_tables = <<~HEREDOC
  SELECT table_name
    FROM information_schema.tables
   WHERE table_schema='public'
     AND table_type='BASE TABLE';
  HEREDOC

  def self.all_tables
    @@all_tables
  end
end
