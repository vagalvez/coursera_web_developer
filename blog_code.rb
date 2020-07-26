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
has_many :comments, dependent: :destroy #dependent destroy eliminará todos los dependientes

#hacer lo mismo para todas las tablas (usando has_many, belongs_to)

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