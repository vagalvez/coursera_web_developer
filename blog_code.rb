#borrar carpeta oculta que crea MACOSX
zip --delete blog.zip "__MACOSX/*"

#HTML guide
https://www.w3schools.com/html/


###############
# ITERACIÓN 1 #
###############

'''
Creamos el andamiaje usando un modelo relacional
con 2 tablas.
'''

#creo la nueva aplicación
rails new blog

#moverme al directorio donde está la aplicación
#cd ../blog

#crear el andamiaje escrbiendo las tablas y atributos de cada tabla
rails generate scaffold Post title:string body:text
rails generate scaffold Comment post:references body:text

#se crea la base de datos
rake db:migrate

#empieza a correr el servidor
rails server

###############
# ITERACIÓN 2 #
###############

'''
Aquí añadimos la tabla users y modificamos el modelo
relacional de tablas para que los datos ya existentes
en la BBDD pueden aguantar el nuevo requerimiento.
'''

#creamos la nueva tabla
rails generate scaffold User first_name:string last_name:string

#creamos la migración para que aparezca el usuario para cada post (user:references es la foreign key)
rails generate migration AddUseridToPosts \
 user:references

#creamos la migración para que aparezca el usuario para cada post (user:references es la foreign key)
rails generate migration AddUseridToComments \
 user:references

#asegurarse de que archivos de cada migración tengan la siguiente forma
add_reference :comments, :user, index:true, foreign_key: true

#ejecutamos la migración
rake db:migrate RAILS_ENV=development #(la migración queda bien si es que se modifica el db/schema.rb)

#empieza a correr el servidor
rails server

###############
# ITERACIÓN 3 #
###############

'''
Añadir asociaciones.
'''

#ir a app/models/post.rb y escribir
has_many :comments, dependent: :destroy  #dependent destroy eliminará todos los dependientes

#ir a app/models/comment.rb y escribir
belongs_to :post
belongs_to :user

#ir a app/models/user.rb y escribir
has_many :posts
has_many :comments

'''
para acceder a la BBDD desde rails console:
$ p = Post.all
$ Comment.all
$ p[1].destroy
$ p[0]
'''

###############
# ITERACIÓN 4 #
###############

'''
Añadir validación
'''

#ir a app/models/post.rb y escribir
validates_presence_of :title
validates_presence_of :body

#ir a app/models/comment.rb y escribir
validates_presence_of :post_id
validates_presence_of :body

###########################
# APLICACIONES MIDDLEWARE #
###########################

#en carpeta /lib crear el archivo timer.rb con lo siguiente:
class Timer
  def initialize(app)
  	@app = app
  end

  def call(env)
  	start = Time.now
  	status, headers, response = @app.call(env)
  	stop = Time.now
  	headers['X-Timing'] = (stop - start).to_s
  	[status, headers, response]
  end
end

#luego ir a config/application.rb y escribir
require_relative '../lib/timer'

#en mismo archivo, en class Aplication escribir
config.middleware.insert_before(Rack::Sendfile, Timer)

#en terminal escribir:
rake middleware #debiera aparecer el timer


###############
# ITERACIÓN 5 #
###############

'''
Añadir AJAX.
'''

#ir a /blog/app/views/posts/_post.html.erb
#crear un archivo _post.html.erb y escribir en él:
<%= div_for @post do %>
  <h2><%= h(@post.title) %></h2>
  <%= simple_format h(@post.body) %>
<% end %>

#copiar el archivo show.html.erb, renombrarlo show-old.html.erb
# y modificarlo para que quede como sigue:
<p id="notice"><%= notice %></p>

<%= render @post %>

<h2>Comments</h2>
<div id="comments">
  <%= render @post.comments.reverse %>
</div>

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>

#ir a /../views/comments y crear un archivo _comment.html.erb:
<%= div_for comment do %>
  <p><strong>
  	Posted <%= time_agoin_words(comment.created_at) %>
  	</strong>
  	<br />
  	<%= h(comment.body) %>
  </p>
<% end %>

#ir a /../views/posts/show.html.erb y que quede como sigue:
<p id="notice"><%= notice %></p>

<%= render @post %>

<h2>Comments</h2>
<div id="comments">
  <%= render @post.comments.reverse %>
</div>

<%=  form_for [@post, Comment.new], remote: true do |f| %>
  <p>
  	<%= f.label :body, "New Comment" %><br />
  	<%= f.text_area :body %>
  </p>
  <p><%= f.submit "Add Comment" %></p>
<% end %>

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>

#ir a config/routes.rb y escribir esto:
resources: posts do
	resources: comments
end

#crear en app/views/comments/create.js.erb un archivo create.js.erb con lo siguiente:
var new_comment = $("<%= j(render(@comment))%>").hide();
$('#comments').prepend(new_comment);
$('#comment_<%= @comment.id %>').fadeIn('slow');
$('#new_comment')[0].reset();