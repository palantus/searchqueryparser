# Search-query Parser

Turns a query like `tag:mytag (property:value|property:value2)` into an object:

```
{
  "type": "and",
  "e1": {
    "type": "token",
    "token": "mytag",
    "tag": "tag"
  },
  "e2": {
    "type": "par",
    "e": {
      "type": "or",
      "e1": {
        "type": "token",
        "token": "value",
        "tag": "property"
      },
      "e2": {
        "type": "token",
        "token": "value2",
        "tag": "property"
      }
    }
  }
}
```

It supports :
 - parentheses. Can be nested indefinitely
 - not (!)
 - and (<space>)
 - or (|)
 - quotes (""). Can contain spaces

Sample usage with async/await:

```
let SearchQueryParser = require("searchqueryparser")

let parser = new SearchQueryParser();
await parser.init()
let result = parser.parse("tag:mytag (property:value|property:value2)")
console.log(JSON.stringify(result, null, 2))

```

Sample usage without async/await
```
let SearchQueryParser = require("searchqueryparser")

let parser = new SearchQueryParser();
parser.init().then(() => {
  let result = parser.parse("tag:mytag (property:value|property:value2)")
  console.log(JSON.stringify(result, null, 2))
})
```
