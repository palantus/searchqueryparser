"use strict"

const fs = require("fs")
const path = require("path")
const jison = require("jison")
let instance = null

class SearchQueryParser{
  initPromise = null;

  async init(){
    if(instance){
      await instance.initPromise
      this.parser = instance.parser
    }

    instance = this;
    this.initPromise = new Promise(async resolveInit => {
      let bnf = await new Promise((r) => fs.readFile(path.join(__dirname, "searchtokens.jison"), "utf8", (err, data) => r(data)));
      this.parser = new jison.Parser(bnf);
      resolveInit()
    })
    await this.initPromise
  }

  parse(exp){
    if(!this.parser){
      if(instance.parser)
        this.parser = instance.parser
      else
        throw "SearchQueryParser isn't initialized. Please wait for init promise to complete before using parse"
    }
    return this.parser.parse(exp)
  }

  static instance(){
    return instance;
  }
}

module.exports = SearchQueryParser
