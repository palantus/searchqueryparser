/* lexical grammar */
%lex

%%
[a-zA-ZæøåÆØÅ0-9\-?><=_@&%0/.,;~^*]+  return 'TEXT';
"\""                      return 'QUOTE';
\s+                       return 'SPACE';
":"                       return 'COLON';
"("                       return 'PARSTART';
")"                       return 'PAREND';
"|"                       return 'OR';
"!"                       return 'NOT';
<<EOF>>                   return 'EOF';

/lex

%start main

%% /* language grammar */

main
    : expression EOF
        {return $1;}
    ;

textwithsymbols
    : TEXT SPACE textwithsymbols
      {$$ = $1 + " " + $3}
    | TEXT COLON textwithsymbols
      {$$ = $1 + ":" + $3}
    | TEXT
      {$$ = $1}
    ;

tag
    : QUOTE textwithsymbols QUOTE
      {$$ = $2}
    | TEXT
      {$$ = $1}
    ;

token
    : tag COLON tag
      {$$ = {type: "token", token: $3, tag: $1}}
    | tag COLON
      {$$ = {type: "token", token: '', tag: $1}}
    | tag
      {$$ = {type: "token", token: $1}}
    | NOT token
      {$$ = {type: "not", e: $2}}
    | PARSTART expression PAREND
      {$$ = $2}
    ;

expression
    : token SPACE expression
      {$$ = {type: "and", e1: $1, e2: $3}}
    | token OR expression
      {$$ = {type: "or", e1: $1, e2: $3}}
    | token
      {$$ = $1}
    ;
