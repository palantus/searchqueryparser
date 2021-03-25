"use strict"

const fs = require("fs")
const path = require("path")
const jison = require("jison")
let instance = null

class SearchQueryParser{
  async init(){
    if(instance){
      this.parser = instance.parser
    } else {
      let bnf = await new Promise((r) => fs.readFile(path.join(__dirname, "searchtokens.jison"), "utf8", (err, data) => r(data)));
      this.parser = new jison.Parser(bnf);
    }
    instance = this;
  }

  parse(exp){
    return this.parser.parse(exp)
  }

  static instance(){
    return instance;
  }
}

module.exports = SearchQueryParser
