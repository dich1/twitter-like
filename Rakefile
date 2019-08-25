# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

Rake::Task['db:migrate'].enhance do
  if Rails.env.development?
    Rake::Task[:after_migrate].invoke
  end
end
  
task :after_migrate do
  Rake::Task[:create_erd].invoke
  Rake::Task[:create_classd].invoke
  Rake::Task[:create_schema_doc].invoke
end
  
task :create_erd do
  sh 'bin/rake erd attributes=foreign_keys,primary_keys,content,timestamp sort=false filename=erd filetype=png'
end
  
task :create_classd do
  sh 'yard doc'
  sh 'yard graph --full -f classd.dot'
  sh 'dot -Tpng classd.dot -o classd.png'
  sh 'rm classd.dot'
end
  
task :create_schema_doc do
  sh 'mysqldump -u root -h db --no-data --xml twitter_like_development > schema.xml'
  sh 'xsltproc -o schema.html style.xsl schema.xml'
  sh 'xvfb-run -a -s "-screen 0 1024x768x24" wkhtmltopdf schema.html schema.pdf'
  sh 'pdftoppm -png schema.pdf schema'
  sh 'convert -append schema-1.png schema-2.png schema.png'
  sh 'rm schema.html schema.xml schema.pdf schema-1.png schema-2.png'
end