/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2000 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jamison for suggestions and comments.      *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%%

%class Lexer
%byaccj
%int

%{

  public Parser   yyparser;
  public int      linenum = 1;

  public Lexer(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

digit      = [0-9]
number     = {digit}+
real       = {number}("."{number})?(E[+-]?{number})?
identifier = [A-Za-z_][A-Za-z0-9_]*
newline    = \n
whitespace = [ \t\r]+
comment    = "//".*

%%

"main"          {   yyparser.linenum = linenum; return Parser.MAIN    ; }
"("             {   yyparser.linenum = linenum; return Parser.LPAREN  ; }
")"             {   yyparser.linenum = linenum; return Parser.RPAREN  ; }
"{"             {   yyparser.linenum = linenum; return Parser.BEGIN   ; }
"}"             {   yyparser.linenum = linenum; return Parser.END     ; }
";"             {   yyparser.linenum = linenum; return Parser.SEMI    ; }
"int"           {   yyparser.linenum = linenum; return Parser.INT     ; }
"print"         {   yyparser.linenum = linenum; return Parser.PRINT   ; }
"="        		{   yyparser.linenum = linenum; return Parser.ASSIGN  ; }
"+"             {   yyparser.linenum = linenum; return Parser.PLUS    ; }
"*"             {   yyparser.linenum = linenum; return Parser.MUL     ; }
"float"		{   yyparser.linenum = linenum; return Parser.FLOAT   ; }
"bool"		{   yyparser.linenum = linenum; return Parser.BOOL    ; }
"," 		{   yyparser.linenum = linenum; return Parser.COMMA   ; }
"while" 	{   yyparser.linenum = linenum; return Parser.WHILE   ; }
"if"		{   yyparser.linenum = linenum; return Parser.IF      ; }
"else"		{   yyparser.linenum = linenum; return Parser.ELSE    ; }
"return"	{   yyparser.linenum = linenum; return Parser.RETURN  ; }
"or"		{   yyparser.linenum = linenum; return Parser.OR      ; }
"and"		{   yyparser.linenum = linenum; return Parser.AND     ; }
"not"		{   yyparser.linenum = linenum; return Parser.NOT     ; }
"=="		{   yyparser.linenum = linenum; return Parser.EE      ; }
"!="		{   yyparser.linenum = linenum; return Parser.NE      ; }
"<"		{   yyparser.linenum = linenum; return Parser.less    ; }
">"		{   yyparser.linenum = linenum; return Parser.great   ; }
">="		{   yyparser.linenum = linenum; return Parser.greatE  ; }
"<="		{   yyparser.linenum = linenum; return Parser.lessE   ; }
"-"		{   yyparser.linenum = linenum; return Parser.MINUS   ; }
"/"		{   yyparser.linenum = linenum; return Parser.DIVIDE  ; }
"%"		{   yyparser.linenum = linenum; return Parser.PERCENT ; }
"true"		{   yyparser.linenum = linenum; return Parser.TRUTH   ; }
"false"		{   yyparser.linenum = linenum; return Parser.FALSEHOOD;}

{number}        {   yyparser.linenum = linenum; yyparser.yylval = new ParserVal(yytext()); return Parser.NUM ; }

{real}          {   yyparser.linenum = linenum; yyparser.yylval = new ParserVal(yytext()); return Parser.REAL; }

{identifier}    {   yyparser.linenum = linenum; yyparser.yylval = new ParserVal(yytext()); return Parser.ID  ; }

{comment}       {   /* skip */}
{newline}       {   linenum++; /* skip */}
{whitespace}    {   /* skip */}

\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    {} /*{ System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }*/
