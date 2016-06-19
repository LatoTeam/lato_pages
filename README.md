# Lato Pages

**Lato** è un progetto italiano di software modulare sviluppato in Ruby on Rails.
Il modulo **lato_pages** è in grado di offrire diverse funzionalità tra le quali:

* Gestione pagine con custom fields
* Api per accedere ai dati delle pagine
* Funzioni per accedere ai dati della pagine

## Installazione

Aggiungere la gemma alla vostra applicazione

```ruby
gem 'lato_pages', git: 'https://github.com/LatoTeam/lato_pages.git'
```
Installare la gemma ed eseguire le migrazioni

```console
bundle install
bundle exec rake db:migrate
```

Creare il file di configurazione

```console
rake lato_pages_initialize
```

## Configurazione (opzionale)

La configurazione di Lato Pages può essere eseguita modificando il file di configurazione presente in /config/lato/pages.yml

## Sviluppare con Lato Pages

Per sviluppare utilizzando le funzioni messe a disposizione da Lato è possibile consultare la documentazione di ogni singolo modulo.
