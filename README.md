# README

## Instalación de elasticsearch

Para distribuciones debian de linux

Ref:
https://www.elastic.co/guide/en/elasticsearch/reference/7.17/deb.html


### Importar la clave PGP de Elasticsearch
```
 $ wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
```


### Instalando el repositorio APT

```
 $ sudo apt-get install apt-transport-https
```

```
 $ echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
```

```
 $ sudo apt-get install elasticsearch
```


### Corriendo Elasticsearch con systemd
```
 $ sudo systemctl status elasticsearch.service
 $ sudo systemctl start elasticsearch.service
 $ sudo systemctl stop elasticsearch.service
```

---

### Crear la aplicacion

```
 $ ruby --version
```
_ruby 2.7.8p225 (2023-03-30 revision 1f4d455848) [x86_64-linux]_

```
 $ rails --version
```
_Rails 7.1.4.1_


```
 $ rails new searchkick-demo
```

---

## Usando Searchkick para búsquedas inteligentes con Rails y Elasticsearch

Ref: https://dzone.com/articles/searchkick-using-rails-and-elasticsearch-for-smart

Para usar elasticsearch se debe usar su cliente y la gema searchkick, se debe agregar al gemfile:

gem "elasticsearch"  
gem "searchkick", "~> 5.2"

---

### Creando scaffold

```
 $ rails generate scaffold Book title:string author:string genre:string price:decimal
```

### Migrando deb

```
 $ rails db:migrate
```

### Populando DB

```
 $ rails console
```


```
Book.create(title: 'Puro', author: 'Julianna Baggott', genre: 'juvenil', price: 10)  
Book.create(title: 'Origen', author: 'Jessica Khoury', genre: 'histórico', price: 12)  
Book.create(title: 'Máscaras', author: 'Amy Harmon', genre: 'zxcv', price: 15)  
Book.create(title: 'Rebeca', author: 'Daphne du Maurier', genre: 'suspenso', price: 12)  
Book.create(title: 'Dune', author: 'Frank Herbert', genre: 'ficción', price: 15)  
Book.create(title: 'Drácula', author: 'Bram Stoker', genre: 'terror', price: 10)  
Book.create(title: 'Niebla', author: 'Miguel de Unamuno', genre: 'Existencialismo', price: 12)  
Book.create(title: 'Rayuela', author: 'Julio Cortázar', genre: 'experimental', price: 15)  
```

### Configurando rutas
config/rootes.rb

```
Rails.application.routes.draw do
  root 'books#index'
  resources :books
end
```

### Personalizar el modelo Book para implementar criterios de coincidencia parcial utilizando la palabra clave word_start:
app/models/book.rb

```
class Book < ApplicationRecord
  searchkick word_start: [:title, :author, :genre]

  def search_data
    {
      title: title,
      author: author,
      genre: genre
    }
  end
end
```

### Re-indexar para añadir datos al índice de búsqueda
Asegurarse de ejecutar este comando cada vez que Searchkick implemente cambios en el modelo

```
 $ rails console
```

```
Book.reindex
```

### Consultar y buscar todo:

```
 $ rails console
```

```
Book.search "*"
```

### Coincidencias parciales

```
 $ rails console
```

```
Book.search "science fiction" # science AND fiction
```

### Si desea buscar tanto en la ciencia como en la ficción

```
 $ rails console
```

```
Book.search "science fiction", operator: "or" # science AND fiction
```

###  Coincidencias exactas

```
 $ rails console
```

```
Book.search params[:q], fields:[{genre: :exact}, :title]
```

###  Coincidencias de frases

```
 $ rails console
```

```
Book.search "Religion, Spirituality & New Age", match: :phrase
```
