####################
# CREAR APLICACIÓN #
####################

#para crear una aplicación ruby:
rails new hello_WWW

#change to application directory:
cd hello_WWW

#start the web server
rails server

#abrir página web
http://localhost:3000

###################
# CREAR ANDAMIAJE #
###################

#crear andamiaje: para que usuario pueda ingresar los pioneros, escribiendo first_name y last_name
rails generate scaffold pioneeer first_name:string last_name:string

#migrar la BBDD
rake db_migrate

#start the web server
rails server

################
# USAR CONSOLA #
################

ruby -e 'puts "Hello world!"'

rails console

# para explorar la BBDD
rails console
names = Pioneer.all #la tabla Pioneer ahora es un array
names[0] #devuelve primer elemento
names[0].first_name #devuelve first_name del primer elemento
names[0].last_name #devuele last_name del primer elemento
names.length #largo de la tabla

#ingresar elementos en tabla
rails console
Pioneer.create(:first_name => "John", :last_name => "von Neumann")


###########
# OBJETOS #
###########

#método class devuelve el tipo de objeto

rails console #para arbir irb, o simplemente irb
1.class()
1.class
1.0.class
"Foo".class

#para ver todos los métodos disponibles para una clase de objeto
1.methods


#############
# VARIABLES #
#############

name 	#variable local
@name   #variable de instancia
@@name  #variable de clase
$name   #variable global
Name    #constantes empiezan con mayúscula

###################
# INVOCAR MÉTODOS #
###################

object.method

##########
# MÉTODO #
##########

#se definen usando def
def min(x,y)
	if x < y then x else y end
end

#si el nombre del método termina con ?, retorna un booleano
#si el nombre del método termina con !, el método puede cambiar el estado del objeto
#self se usa dentro del método para referirse al objeto actual

##########
# CLASES #
##########

#se escriben usando CamelCase
#las clases nunca se cierran, siempre peden extenderse

#creo la clase
class MyClass
	@boo = 1 #una variable de instancia
	def my_method
		@foo = 2 #una variable de instancia
	end
end

#creo un objeto de la clase
mo = MyClass.new

#ejecuto un método
mo.my_method #imprime 2 (valor de @foo)
mo.@boo #esto no se puede hacer, no muestra valor de variables

#creo una clase en la que puedo obtener el valor de una variable
class MyClass
	def boo  # un metodo de acceso a la variable
		return @boo
	end
	def boo=(val)  #un metodo de asignacion
		@boo = val
	end
end

#probamos la clase anterior
mo = MyClass.new #crea un objeto MyClass
mo.boo = 1       #asigno valor a la variable
mo.boo			 #me devuelve el valor de la variable

#extendemos la clase Fixnum
class Fixnum
	def previous
		return self-1
	end
end

#####################
# MÉTODOS DE CLASES #
#####################

#llevan el prefijo self
class MyClass
	def self.cls_method
		"MyClass type"
	end
end

#############
# ACCESORES #
#############

#método rápido de hacer lo del último ejemplo
class MyClass
	attr_accessor :boo
end

#otro ejemplo
class Person
	attr_accessor :first_name, :last_name
end

#################
# CONSTRUCTORES #
#################

#para inicializar variables con un valor específico
class MyClass
	attr_accessor :boo
	def initalize(x=1)
		@boo = x
	end
end

#para probarlo
mo = MyClass.new
mo.boo
a

############
# HERENCIA #
############

class NewClass < SuperClass
	...
end

############################
# INTERPOLACIÓN DE CADENAS #
############################

#al string escrito usando comillas dobales,
#se añade #{} y se mostrará el cálculo

#devuelve el valor en radianes
"360 grados = #{2*Math::PI} radianes"

#devuelve el timestamp actual
`date`

name = "Homer Blimpson"
name.length
name[6]
name[6..14]
"Bart " + name[6..14]
name = name[0..4]
name.encoding

#################################################
# EXPRESIONES REGULARES O CARACTERES DE CONTROL #
#################################################

#puede probar expresiones regulares en rubular.com

"Homer" =~ /er/
"Homer" =~ /hom/
"Homer" =~ /Hom/
"Homer" =~ /hom/i #con la i ignora la capitalización de las palabras

[ ] #para especificar rango ([a-z] es el rango entre a y z)
\w #caracter de palabra
\W #caracter no de palabra
\s #caracter espacio
\S #caracter no espacio
\d #caracter dígito
\D #caracter no dígito
\A #inicio de cadena
\z #fin de cadena
\b #límites de palabra
* #cero o más repeticiones de lo anterior
+ #uno o más repeticiones de lo anterior
{m,n} #al menos m y como máximo n repeticiones de lo anterior
? #como máximo una repetición de lo anterior
| #anterior o posterior expresión deben ser iguales
( ) #agrupamiento

#para dejar sólo los números y eliminar todo lo que no sea número
telefono = "(555) 646-2213"
telefono.gsub!(/\D/, "")

#para confirmar que es un correo electrónico
email = /\A[\w\.-]+\@[a-z]+\.[a-z]{3}\z/
"greg@gmail.com" =~ email
"greggmailcom" =~ email

############
# SÍMBOLOS #
############

#se crean añadiendo dos puntos
#se pueden asignar símbolos a una variable i.e. es correcto name = :homer
# los símbolos son inmutables i.e. es incorrecto :name = "homer"

#si necesita manipular el contenido del objeto (i.e. la secuencia de caracteres) -> use una cadena (string)
#si la identidad del objeto es importante (no se quiere manipular los caracteres) -> use un símbolo

##########################
# ESTRUCTURAS DE CONTROL #
##########################

if condicion
	codigo
elsif condicion
	codigo
else condicion
	codigo
end

codigo if condicion

codigo unless condicion

expresion ? codigo

#operadores de comparacion
==, !=, <, <=, >, >=, <=>, =~, !~

for var in coleccion do
	codigo
end

while condicion
	codigo
end

until condicion
	codigo
end

#########
# ARRAY #
#########

#crea el array a
a = [33.3, "hi", 2]

#muestra el primer elemento del array
a[0]

#muestra elementos desde posición a hasta la posición b
a[1..2]

#append
a << 5

#último elemento de array
a[-1]

#para saber si hay un elemento en el array
a.include? 2

########
# HASH #
########

#para definir el hash
phone = {:home => 1, :mobile => 2, :work => 3}

phone[:home] #devuelve el 1
phone.key(1) #devuelve home
phone.key?(:home) #devuelve true
phone.value?(1)   #devuelve true

#####################
# BLOQUES DE CÓDIGO #
#####################

method_name(parameter_list){block}

#un bloque pasado a un método es invocado usando yield

def three_times
	yield
	yield
	yield
end

three_times {puts "Hello"}