*Installation
- rbenv, ruby
- libmagic library https://github.com/blackwinter/ruby-filemagic
- bundle install

*Run service: 

```
ruby app.rb
```

*Send request:
- Send file to convert from json to xml (data must be specified by -F)
```
curl -i -v -X POST -F file=@path/to/file -F i=json -F o=xml http://localhost:4567/
```

E.g:
```
curl -i -v -X POST -F file=@myfile.json -F i=json -F o=xml http://localhost:4567/
```

Response: 
```
<?xml version="1.0" encoding="UTF-8"?>
<hash>
  <catalog>
    <book>
      <id>bk101</id>
      <author>Gambardella, Matthew</author>
      <title>XML Developer's Guide</title>
      <genre>Computer</genre>
      <price>44.95</price>
      <publish-date>2000-10-01</publish-date>
      <description>An in-depth look at creating applications 
      with XML.</description>
    </book>
  </catalog>
</hash>
```

- Send file to convert from xml to json
```
curl -i -v -X POST -F file=@myfile.xml -F i=xml -F o=json http://localhost:4567/
```

Response:
```
{"catalog":{"book":{"id":"bk101","author":"Gambardella, Matthew","title":"XML Developer's Guide","genre":"Computer","price":"44.95","publish_date":"2000-10-01","description":"An in-depth look at creating applications \n      with XML."}}}
```

- Send text to convert from json to xml (remember to escape double quote char)
```
curl -i -v -X POST -d text="{"catalog":{"book":[{"id":"bk101","author":"Gambardella, Matthew"}]}}" -d i=xml -d o=json http://localhost:4567/
```

- Send text to convert from xml to json (remember to escape double quote char)
```
curl -i -v -X POST -d text="<catalog><book id=\"bk101\"><author>Gambardella, Matthew</author></book></catalog>" -d i=xml -d o=json http://localhost:4567/
```
