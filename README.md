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
