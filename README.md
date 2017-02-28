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

Sample usage:

```
let SearchQueryParser = require("searchqueryparser")

let parser = new SearchQueryParser();
parser.init().then(() => {
  let result = parser.parse("tag:mytag (property:value|property:value2)")
  console.log(JSON.stringify(result, null, 2))
})
```
