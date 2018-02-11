//### This file created by BYACC 1.8(/Java extension  1.15)
//### Java capabilities added 7 Jan 97, Bob Jamison
//### Updated : 27 Nov 97  -- Bob Jamison, Joe Nieten
//###           01 Jan 98  -- Bob Jamison -- fixed generic semantic constructor
//###           01 Jun 99  -- Bob Jamison -- added Runnable support
//###           06 Aug 00  -- Bob Jamison -- made state variables class-global
//###           03 Jan 01  -- Bob Jamison -- improved flags, tracing
//###           16 May 01  -- Bob Jamison -- added custom stack sizing
//###           04 Mar 02  -- Yuval Oren  -- improved java performance, added options
//###           14 Mar 02  -- Tomas Hurka -- -d support, static initializer workaround
//### Please send bug reports to tom@hukatronic.cz
//### static char yysccsid[] = "@(#)yaccpar	1.8 (Berkeley) 01/20/90";






//#line 1 "Parser.y"

import java.io.*;
//#line 20 "Parser.java"




public class Parser
             extends ParserBase
{

boolean yydebug;        //do I want debug output?
int yynerrs;            //number of errors so far
int yyerrflag;          //was there an error?
int yychar;             //the current working character

//########## MESSAGES ##########
//###############################################################
// method: debug
//###############################################################
void debug(String msg)
{
  if (yydebug)
    System.out.println(msg);
}

//########## STATE STACK ##########
final static int YYSTACKSIZE = 500;  //maximum stack size
int statestk[] = new int[YYSTACKSIZE]; //state stack
int stateptr;
int stateptrmax;                     //highest index of stackptr
int statemax;                        //state when highest index reached
//###############################################################
// methods: state stack push,pop,drop,peek
//###############################################################
final void state_push(int state)
{
  try {
		stateptr++;
		statestk[stateptr]=state;
	 }
	 catch (ArrayIndexOutOfBoundsException e) {
     int oldsize = statestk.length;
     int newsize = oldsize * 2;
     int[] newstack = new int[newsize];
     System.arraycopy(statestk,0,newstack,0,oldsize);
     statestk = newstack;
     statestk[stateptr]=state;
  }
}
final int state_pop()
{
  return statestk[stateptr--];
}
final void state_drop(int cnt)
{
  stateptr -= cnt; 
}
final int state_peek(int relative)
{
  return statestk[stateptr-relative];
}
//###############################################################
// method: init_stacks : allocate and prepare stacks
//###############################################################
final boolean init_stacks()
{
  stateptr = -1;
  val_init();
  return true;
}
//###############################################################
// method: dump_stacks : show n levels of the stacks
//###############################################################
void dump_stacks(int count)
{
int i;
  System.out.println("=index==state====value=     s:"+stateptr+"  v:"+valptr);
  for (i=0;i<count;i++)
    System.out.println(" "+i+"    "+statestk[i]+"      "+valstk[i]);
  System.out.println("======================");
}


//########## SEMANTIC VALUES ##########
//public class ParserVal is defined in ParserVal.java


String   yytext;//user variable to return contextual strings
ParserVal yyval; //used to return semantic vals from action routines
ParserVal yylval;//the 'lval' (result) I got from yylex()
ParserVal valstk[];
int valptr;
//###############################################################
// methods: value stack push,pop,drop,peek.
//###############################################################
void val_init()
{
  valstk=new ParserVal[YYSTACKSIZE];
  yyval=new ParserVal();
  yylval=new ParserVal();
  valptr=-1;
}
void val_push(ParserVal val)
{
  if (valptr>=YYSTACKSIZE)
    return;
  valstk[++valptr]=val;
}
ParserVal val_pop()
{
  if (valptr<0)
    return new ParserVal();
  return valstk[valptr--];
}
void val_drop(int cnt)
{
int ptr;
  ptr=valptr-cnt;
  if (ptr<0)
    return;
  valptr = ptr;
}
ParserVal val_peek(int relative)
{
int ptr;
  ptr=valptr-relative;
  if (ptr<0)
    return new ParserVal();
  return valstk[ptr];
}
final ParserVal dup_yyval(ParserVal val)
{
  ParserVal dup = new ParserVal();
  dup.ival = val.ival;
  dup.dval = val.dval;
  dup.sval = val.sval;
  dup.obj = val.obj;
  return dup;
}
//#### end semantic value section ####
public final static short OR=257;
public final static short AND=258;
public final static short NOT=259;
public final static short EE=260;
public final static short NE=261;
public final static short less=262;
public final static short great=263;
public final static short greatE=264;
public final static short lessE=265;
public final static short PLUS=266;
public final static short MINUS=267;
public final static short MUL=268;
public final static short DIVIDE=269;
public final static short PERCENT=270;
public final static short NUM=271;
public final static short ID=272;
public final static short REAL=273;
public final static short MAIN=274;
public final static short PRINT=275;
public final static short BEGIN=276;
public final static short END=277;
public final static short ASSIGN=278;
public final static short LPAREN=279;
public final static short RPAREN=280;
public final static short SEMI=281;
public final static short INT=282;
public final static short COMMA=283;
public final static short TRUTH=284;
public final static short FALSEHOOD=285;
public final static short ELSE=286;
public final static short IF=287;
public final static short FLOAT=288;
public final static short BOOL=289;
public final static short RETURN=290;
public final static short WHILE=291;
public final static short YYERRCODE=256;
final static short yylhs[] = {                           -1,
    0,   19,   19,   21,   21,   17,   20,    2,   13,   13,
   14,    5,    5,    6,    6,    6,    6,    6,    6,   22,
    8,    3,    3,    4,    1,    1,    1,    7,   15,   15,
    9,    9,   18,   18,   18,   18,   18,   18,   18,   18,
   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,
   18,   18,   18,   11,   10,   12,   16,   16,
};
final static short yylen[] = {                            2,
    2,    2,    0,    1,    0,    6,    1,    4,    3,    1,
    1,    2,    0,    1,    1,    1,    1,    1,    1,    0,
    5,    2,    0,    3,    1,    1,    1,    3,    3,    1,
    4,    1,    3,    3,    3,    1,    3,    3,    2,    3,
    3,    3,    3,    3,    3,    3,    3,    3,    1,    1,
    1,    4,    1,    5,    7,    2,    1,    0,
};
final static short yydefred[] = {                         3,
    0,    0,    0,   25,   26,   27,    0,    1,    7,    2,
    0,    0,    0,    0,   20,    8,   11,    0,   10,    0,
   23,    0,    0,    0,    9,    6,    0,   22,    0,    0,
    0,    0,   21,   32,    0,    0,    0,   12,   15,   14,
   16,   17,   18,   19,   24,    0,    0,   36,    0,   53,
    0,   50,   51,    0,    0,   56,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,   28,    0,    0,   31,    0,    0,
    0,   35,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,   34,   46,   45,    0,    0,    0,   52,    0,
   54,    0,    0,   55,
};
final static short yydgoto[] = {                          1,
   17,    8,   24,   28,   29,   38,   39,   40,   41,   42,
   43,   44,   18,   19,   79,   80,    9,   54,    2,   10,
   20,   21,
};
final static short yysindex[] = {                         0,
    0,   65, -277,    0,    0,    0, -264,    0,    0,    0,
 -265, -247, -221, -276,    0,    0,    0, -224,    0, -210,
    0, -276, -195, -276,    0,    0, -187,    0,   53, -193,
 -185,  -67,    0,    0, -190, -184, -173,    0,    0,    0,
    0,    0,    0,    0,    0,  -67,  -67,    0, -164,    0,
  -67,    0,    0,  -34,  -67,    0,  -67,  -12,  133,  -67,
   10,  -67,  -67,  -67,  -67,  -67,  -67,  -67,  -67,  -67,
  -67,  -67,  -67,  -67,    0,   31,   52,    0, -166, -160,
  109,    0,  122,  133, -222, -222, -222, -222, -222, -222,
 -219, -219,    0,    0,    0,   74,   74,  -67,    0, -163,
    0,  109,   74,    0,
};
final static short yyrindex[] = {                         0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0, -158,    0,    0,    0, -156,    0,    0,
    0,    0,    0,   61,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0, -227,    0,
    0,    0,    0,    0,    0,    0,    0,    0,  -72, -155,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0, -154,    0,
 -201,    0, -167,  -61, -162, -153, -126, -117,  -90,  -81,
 -200, -189,    0,    0,    0,    0,    0,    0,    0,    0,
    0, -196,    0,    0,
};
final static short yygindex[] = {                         0,
    5,    0,    0,    0,    0,  -93,    0,  116,    0,    0,
    0,    0,    0,  111,    0,    0,    0,  -46,    0,    0,
    0,    0,
};
final static int YYTABLESIZE=403;
static short yytable[];
static { yytable();}
static void yytable(){
yytable = new short[]{                         58,
   59,   11,  100,  101,   61,    4,    7,   12,   76,  104,
   77,    5,    6,   81,   13,   83,   84,   85,   86,   87,
   88,   89,   90,   91,   92,   93,   94,   95,   27,   49,
   49,   14,   49,   49,   49,   49,   49,   49,   49,   49,
   49,   49,   49,   70,   71,   72,   73,   74,   72,   73,
   74,  102,   49,   49,   15,   49,   33,   33,   22,   33,
   33,   33,   33,   33,   33,   33,   33,   44,   44,   23,
   44,   44,   44,   44,   44,   44,   44,   44,   30,   33,
   33,   30,   33,   29,   30,   26,   29,   45,   55,   37,
   44,   44,   46,   44,   47,   47,   56,   47,   47,   47,
   47,   47,   47,   48,   48,   57,   48,   48,   48,   48,
   48,   48,   37,   37,   60,   37,   98,   47,   47,   99,
   47,    5,  103,    4,   58,   57,   48,   48,   16,   48,
   42,   42,   25,   42,   42,   42,   42,   42,   42,   40,
   40,    0,   40,   40,   40,   40,   40,   40,    0,    0,
    0,    0,    0,   42,   42,    0,   42,    0,    0,    0,
    0,    0,   40,   40,    0,   40,   41,   41,    0,   41,
   41,   41,   41,   41,   41,   43,   43,    0,   43,   43,
   43,   43,   43,   43,   39,   39,    0,    0,    0,   41,
   41,   47,   41,    0,    0,   38,   38,    0,   43,   43,
    0,   43,    0,   48,   49,   50,    0,   39,   39,    0,
   39,   51,    0,    0,    0,    0,   52,   53,   38,   38,
    0,   38,   62,   63,    0,   64,   65,   66,   67,   68,
   69,   70,   71,   72,   73,   74,    0,    0,    0,    0,
    0,    0,    0,    0,   62,   63,   75,   64,   65,   66,
   67,   68,   69,   70,   71,   72,   73,   74,    0,    0,
    0,    0,    0,    0,    0,    0,   62,   63,   78,   64,
   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
    0,    0,    0,    0,    0,    0,    0,   62,   63,   82,
   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,
   74,    0,    0,    0,    0,    0,    0,    0,   62,   63,
   96,   64,   65,   66,   67,   68,   69,   70,   71,   72,
   73,   74,    0,    0,   31,    0,    0,   32,   15,   33,
    0,   97,   13,   34,    0,   13,   13,   13,    3,   35,
    0,   13,   36,   37,    0,   31,    4,   13,   32,   15,
   13,   13,    5,    6,   34,    0,    0,    0,    0,    0,
   35,    0,    0,   36,   37,   62,   63,    0,   64,   65,
   66,   67,   68,   69,   70,   71,   72,   73,   74,   63,
    0,   64,   65,   66,   67,   68,   69,   70,   71,   72,
   73,   74,   64,   65,   66,   67,   68,   69,   70,   71,
   72,   73,   74,
};
}
static short yycheck[];
static { yycheck(); }
static void yycheck() {
yycheck = new short[] {                         46,
   47,  279,   96,   97,   51,  282,    2,  272,   55,  103,
   57,  288,  289,   60,  280,   62,   63,   64,   65,   66,
   67,   68,   69,   70,   71,   72,   73,   74,   24,  257,
  258,  279,  260,  261,  262,  263,  264,  265,  266,  267,
  268,  269,  270,  266,  267,  268,  269,  270,  268,  269,
  270,   98,  280,  281,  276,  283,  257,  258,  283,  260,
  261,  262,  263,  264,  265,  266,  267,  257,  258,  280,
  260,  261,  262,  263,  264,  265,  266,  267,  280,  280,
  281,  283,  283,  280,  272,  281,  283,  281,  279,  257,
  280,  281,  278,  283,  257,  258,  281,  260,  261,  262,
  263,  264,  265,  257,  258,  279,  260,  261,  262,  263,
  264,  265,  280,  281,  279,  283,  283,  280,  281,  280,
  283,  280,  286,  280,  280,  280,  280,  281,   13,  283,
  257,  258,   22,  260,  261,  262,  263,  264,  265,  257,
  258,   -1,  260,  261,  262,  263,  264,  265,   -1,   -1,
   -1,   -1,   -1,  280,  281,   -1,  283,   -1,   -1,   -1,
   -1,   -1,  280,  281,   -1,  283,  257,  258,   -1,  260,
  261,  262,  263,  264,  265,  257,  258,   -1,  260,  261,
  262,  263,  264,  265,  257,  258,   -1,   -1,   -1,  280,
  281,  259,  283,   -1,   -1,  257,  258,   -1,  280,  281,
   -1,  283,   -1,  271,  272,  273,   -1,  280,  281,   -1,
  283,  279,   -1,   -1,   -1,   -1,  284,  285,  280,  281,
   -1,  283,  257,  258,   -1,  260,  261,  262,  263,  264,
  265,  266,  267,  268,  269,  270,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,  257,  258,  281,  260,  261,  262,
  263,  264,  265,  266,  267,  268,  269,  270,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,  257,  258,  281,  260,
  261,  262,  263,  264,  265,  266,  267,  268,  269,  270,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,  257,  258,  280,
  260,  261,  262,  263,  264,  265,  266,  267,  268,  269,
  270,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  257,  258,
  280,  260,  261,  262,  263,  264,  265,  266,  267,  268,
  269,  270,   -1,   -1,  272,   -1,   -1,  275,  276,  277,
   -1,  280,  272,  281,   -1,  275,  276,  277,  274,  287,
   -1,  281,  290,  291,   -1,  272,  282,  287,  275,  276,
  290,  291,  288,  289,  281,   -1,   -1,   -1,   -1,   -1,
  287,   -1,   -1,  290,  291,  257,  258,   -1,  260,  261,
  262,  263,  264,  265,  266,  267,  268,  269,  270,  258,
   -1,  260,  261,  262,  263,  264,  265,  266,  267,  268,
  269,  270,  260,  261,  262,  263,  264,  265,  266,  267,
  268,  269,  270,
};
}
final static short YYFINAL=1;
final static short YYMAXTOKEN=291;
final static String yyname[] = {
"end-of-file",null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
null,null,null,"OR","AND","NOT","EE","NE","less","great","greatE","lessE",
"PLUS","MINUS","MUL","DIVIDE","PERCENT","NUM","ID","REAL","MAIN","PRINT",
"BEGIN","END","ASSIGN","LPAREN","RPAREN","SEMI","INT","COMMA","TRUTH",
"FALSEHOOD","ELSE","IF","FLOAT","BOOL","RETURN","WHILE",
};
final static String yyrule[] = {
"$accept : program",
"program : decl_list main_decl",
"decl_list : decl_list decl",
"decl_list :",
"params : param_list",
"params :",
"fun_decl : type_spec ID LPAREN params RPAREN SEMI",
"decl : fun_decl",
"main_decl : MAIN LPAREN RPAREN compound_stmt",
"param_list : param_list COMMA param",
"param_list : param",
"param : type_spec",
"stmt_list : stmt_list stmt",
"stmt_list :",
"stmt : compound_stmt",
"stmt : print_stmt",
"stmt : expr_stmt",
"stmt : if_stmt",
"stmt : while_stmt",
"stmt : return_stmt",
"$$1 :",
"compound_stmt : BEGIN $$1 local_decls stmt_list END",
"local_decls : local_decls local_decl",
"local_decls :",
"local_decl : type_spec ID SEMI",
"type_spec : INT",
"type_spec : FLOAT",
"type_spec : BOOL",
"print_stmt : PRINT expr SEMI",
"arg_list : arg_list COMMA expr",
"arg_list : expr",
"expr_stmt : ID ASSIGN expr SEMI",
"expr_stmt : SEMI",
"expr : expr PLUS expr",
"expr : expr MUL expr",
"expr : LPAREN expr RPAREN",
"expr : NUM",
"expr : expr OR expr",
"expr : expr AND expr",
"expr : NOT expr",
"expr : expr great expr",
"expr : expr greatE expr",
"expr : expr less expr",
"expr : expr lessE expr",
"expr : expr MINUS expr",
"expr : expr PERCENT expr",
"expr : expr DIVIDE expr",
"expr : expr EE expr",
"expr : expr NE expr",
"expr : ID",
"expr : TRUTH",
"expr : FALSEHOOD",
"expr : ID LPAREN args RPAREN",
"expr : REAL",
"while_stmt : WHILE LPAREN expr RPAREN stmt",
"if_stmt : IF LPAREN expr RPAREN stmt ELSE stmt",
"return_stmt : RETURN SEMI",
"args : arg_list",
"args :",
};

//#line 91 "Parser.y"

private Lexer lexer;

private int yylex () {
    int yyl_return = -1;
    try {
        yylval = new ParserVal(0);
        yyl_return = lexer.yylex();
    }
    catch (IOException e) {
        System.err.println("IO error :"+e);
    }
    return yyl_return;
}

public void yyerror (String error) {
    System.out.println("Error: " + error);
}

public Parser(Reader r) {
    lexer = new Lexer(r, this);
}
//#line 394 "Parser.java"
//###############################################################
// method: yylexdebug : check lexer state
//###############################################################
void yylexdebug(int state,int ch)
{
String s=null;
  if (ch < 0) ch=0;
  if (ch <= YYMAXTOKEN) //check index bounds
     s = yyname[ch];    //now get it
  if (s==null)
    s = "illegal-symbol";
  debug("state "+state+", reading "+ch+" ("+s+")");
}





//The following are now global, to aid in error reporting
int yyn;       //next next thing to do
int yym;       //
int yystate;   //current parsing state from state table
String yys;    //current token string


//###############################################################
// method: yyparse : parse input and execute indicated items
//###############################################################
int yyparse()
throws Exception
{
boolean doaction;
  init_stacks();
  yynerrs = 0;
  yyerrflag = 0;
  yychar = -1;          //impossible char forces a read
  yystate=0;            //initial state
  state_push(yystate);  //save it
  val_push(yylval);     //save empty value
  while (true) //until parsing is done, either correctly, or w/error
    {
    doaction=true;
    if (yydebug) debug("loop"); 
    //#### NEXT ACTION (from reduction table)
    for (yyn=yydefred[yystate];yyn==0;yyn=yydefred[yystate])
      {
      if (yydebug) debug("yyn:"+yyn+"  state:"+yystate+"  yychar:"+yychar);
      if (yychar < 0)      //we want a char?
        {
        yychar = yylex();  //get next token
        if (yydebug) debug(" next yychar:"+yychar);
        //#### ERROR CHECK ####
        if (yychar < 0)    //it it didn't work/error
          {
          yychar = 0;      //change it to default string (no -1!)
          if (yydebug)
            yylexdebug(yystate,yychar);
          }
        }//yychar<0
      yyn = yysindex[yystate];  //get amount to shift by (shift index)
      if ((yyn != 0) && (yyn += yychar) >= 0 &&
          yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
        {
        if (yydebug)
          debug("state "+yystate+", shifting to state "+yytable[yyn]);
        //#### NEXT STATE ####
        yystate = yytable[yyn];//we are in a new state
        state_push(yystate);   //save it
        val_push(yylval);      //push our lval as the input for next rule
        yychar = -1;           //since we have 'eaten' a token, say we need another
        if (yyerrflag > 0)     //have we recovered an error?
           --yyerrflag;        //give ourselves credit
        doaction=false;        //but don't process yet
        break;   //quit the yyn=0 loop
        }

    yyn = yyrindex[yystate];  //reduce
    if ((yyn !=0 ) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
      {   //we reduced!
      if (yydebug) debug("reduce");
      yyn = yytable[yyn];
      doaction=true; //get ready to execute
      break;         //drop down to actions
      }
    else //ERROR RECOVERY
      {
      if (yyerrflag==0)
        {
        yyerror("syntax error");
        yynerrs++;
        }
      if (yyerrflag < 3) //low error count?
        {
        yyerrflag = 3;
        while (true)   //do until break
          {
          if (stateptr<0)   //check for under & overflow here
            {
            yyerror("stack underflow. aborting...");  //note lower case 's'
            return 1;
            }
          yyn = yysindex[state_peek(0)];
          if ((yyn != 0) && (yyn += YYERRCODE) >= 0 &&
                    yyn <= YYTABLESIZE && yycheck[yyn] == YYERRCODE)
            {
            if (yydebug)
              debug("state "+state_peek(0)+", error recovery shifting to state "+yytable[yyn]+" ");
            yystate = yytable[yyn];
            state_push(yystate);
            val_push(yylval);
            doaction=false;
            break;
            }
          else
            {
            if (yydebug)
              debug("error recovery discarding state "+state_peek(0)+" ");
            if (stateptr<0)   //check for under & overflow here
              {
              yyerror("Stack underflow. aborting...");  //capital 'S'
              return 1;
              }
            state_pop();
            val_pop();
            }
          }
        }
      else            //discard this token
        {
        if (yychar == 0)
          return 1; //yyabort
        if (yydebug)
          {
          yys = null;
          if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
          if (yys == null) yys = "illegal-symbol";
          debug("state "+yystate+", error recovery discards token "+yychar+" ("+yys+")");
          }
        yychar = -1;  //read another
        }
      }//end error recovery
    }//yyn=0 loop
    if (!doaction)   //any reason not to proceed?
      continue;      //skip action
    yym = yylen[yyn];          //get count of terminals on rhs
    if (yydebug)
      debug("state "+yystate+", reducing "+yym+" by rule "+yyn+" ("+yyrule[yyn]+")");
    if (yym>0)                 //if count of rhs not 'nil'
      yyval = val_peek(yym-1); //get current semantic value
    yyval = dup_yyval(yyval); //duplicate yyval if ParserVal is used as semantic value
    switch(yyn)
      {
//########## USER-SUPPLIED ACTIONS ##########
case 1:
//#line 24 "Parser.y"
{ yyval.obj = CallProgram(val_peek(1).obj, val_peek(0).obj);    }
break;
case 2:
//#line 26 "Parser.y"
{ yyval.obj = calldecllist(val_peek(1).obj, val_peek(0).obj);   }
break;
case 3:
//#line 26 "Parser.y"
{ yyval.obj = 
calldecllisteps(); }
break;
case 4:
//#line 28 "Parser.y"
{yyval.obj = CallParam(val_peek(0).obj);}
break;
case 5:
//#line 28 "Parser.y"
{yyval.obj = CallParamsEps();}
break;
case 6:
//#line 31 "Parser.y"
{yyval.obj = CallFun(val_peek(5).obj, val_peek(4).sval, val_peek(2).obj);}
break;
case 7:
//#line 33 "Parser.y"
{yyval.obj = calldec(val_peek(0).obj);}
break;
case 8:
//#line 35 "Parser.y"
{ yyval.obj = CallMain(val_peek(0).obj);}
break;
case 9:
//#line 38 "Parser.y"
{yyval.obj=CallParamList(val_peek(2).obj, val_peek(0).obj);}
break;
case 10:
//#line 38 "Parser.y"
{yyval.obj=CallParam1(val_peek(0).obj);}
break;
case 11:
//#line 40 "Parser.y"
{yyval.obj = CallParam(val_peek(0).obj);}
break;
case 12:
//#line 42 "Parser.y"
{ yyval.obj = CallStmtListRec(val_peek(1).obj, val_peek(0).obj);}
break;
case 13:
//#line 42 "Parser.y"
{ yyval.obj = CallStmtListEps();}
break;
case 14:
//#line 44 "Parser.y"
{ yyval.obj = CallStmtCompound(val_peek(0).obj); }
break;
case 15:
//#line 44 "Parser.y"
{ yyval.obj = CallStmtPrint(val_peek(0).obj);}
break;
case 16:
//#line 44 "Parser.y"
{yyval.obj = CallExprStmt(val_peek(0).obj);}
break;
case 17:
//#line 44 "Parser.y"
{yyval.obj = CallIfStmt(val_peek(0).obj);}
break;
case 18:
//#line 44 "Parser.y"
{yyval.obj = CallWhileSt(val_peek(0).obj);}
break;
case 19:
//#line 44 "Parser.y"
{yyval.obj = CallReturnStmt(val_peek(0).obj);}
break;
case 20:
//#line 46 "Parser.y"
{ yyval.obj = CallCompoundStmtBegin(); }
break;
case 21:
//#line 46 "Parser.y"
{ yyval.obj = CallCompoundStmtRest(val_peek(3).obj, val_peek(2).obj, val_peek(1).obj); }
break;
case 22:
//#line 48 "Parser.y"
{ yyval.obj = CallLocalDeclsRec(val_peek(1).obj, val_peek(0).obj); }
break;
case 23:
//#line 48 "Parser.y"
{ yyval.obj = CallLocalDeclsEps(); }
break;
case 24:
//#line 50 "Parser.y"
{ yyval.obj = CallLocalDecl(val_peek(2).obj, val_peek(1).sval);}
break;
case 25:
//#line 52 "Parser.y"
{ yyval.obj = CallTypeInt();}
break;
case 26:
//#line 52 "Parser.y"
{yyval.obj = CallTypeFloat();}
break;
case 27:
//#line 52 "Parser.y"
{yyval.obj = CallTypeBool();}
break;
case 28:
//#line 54 "Parser.y"
{ yyval.obj = CallPrintExpr(val_peek(1).sval);}
break;
case 29:
//#line 56 "Parser.y"
{ yyval.obj = CallArgList(val_peek(2).obj, val_peek(0).sval);}
break;
case 30:
//#line 56 "Parser.y"
{yyval.obj = CallArgList2(val_peek(0).sval);}
break;
case 31:
//#line 58 "Parser.y"
{ yyval.obj = CallExprStmtIdAssignExpr(val_peek(3).sval, val_peek(1).sval); }
break;
case 32:
//#line 58 "Parser.y"
{}
break;
case 33:
//#line 60 "Parser.y"
{ yyval.sval = CallExprAdd(val_peek(2).sval, val_peek(0).sval);}
break;
case 34:
//#line 61 "Parser.y"
{ yyval.sval = CallExprMul(val_peek(2).sval, val_peek(0).sval);}
break;
case 35:
//#line 62 "Parser.y"
{ yyval.sval = CallExprParen(val_peek(1).sval);}
break;
case 36:
//#line 63 "Parser.y"
{ yyval.sval = CallFactorNum();}
break;
case 37:
//#line 64 "Parser.y"
{yyval.sval = CallORExpr(val_peek(2).sval, val_peek(0).sval);}
break;
case 38:
//#line 65 "Parser.y"
{yyval.sval = CallANDExpr(val_peek(2).sval, val_peek(0).sval);}
break;
case 39:
//#line 66 "Parser.y"
{yyval.sval = CallNOTEx(val_peek(0).sval);}
break;
case 40:
//#line 67 "Parser.y"
{yyval.sval = CallGreat(val_peek(2).sval, val_peek(0).sval);}
break;
case 41:
//#line 68 "Parser.y"
{yyval.sval = CallGreatEqual(val_peek(2).sval, val_peek(0).sval);}
break;
case 42:
//#line 69 "Parser.y"
{yyval.sval = CallLess(val_peek(2).sval, val_peek(0).sval);}
break;
case 43:
//#line 70 "Parser.y"
{yyval.sval = CallLessEqual(val_peek(2).sval, val_peek(0).sval);}
break;
case 44:
//#line 71 "Parser.y"
{yyval.sval = CallMinus(val_peek(2).sval, val_peek(0).sval);}
break;
case 45:
//#line 72 "Parser.y"
{yyval.sval = CallPercent(val_peek(2).sval, val_peek(0).sval);}
break;
case 46:
//#line 73 "Parser.y"
{yyval.sval = CallDivide(val_peek(2).sval, val_peek(0).sval);}
break;
case 47:
//#line 74 "Parser.y"
{yyval.sval = CallEqual(val_peek(2).sval, val_peek(0).sval);}
break;
case 48:
//#line 75 "Parser.y"
{yyval.sval = CallNotEqual(val_peek(2).sval, val_peek(0).sval);}
break;
case 49:
//#line 76 "Parser.y"
{ yyval.sval = CallExprId(val_peek(0).sval);}
break;
case 50:
//#line 77 "Parser.y"
{ yyval.sval = CallExprTrue();}
break;
case 51:
//#line 78 "Parser.y"
{ yyval.sval= CallExprFalse();}
break;
case 52:
//#line 79 "Parser.y"
{yyval.sval = Callexprargs(val_peek(3).sval, val_peek(1).obj);}
break;
case 53:
//#line 80 "Parser.y"
{yyval.sval = "float";}
break;
case 54:
//#line 82 "Parser.y"
{yyval.obj = CallWhileStmt(val_peek(2).sval, val_peek(0).obj);}
break;
case 55:
//#line 84 "Parser.y"
{ yyval.obj = CallIfEstmt(val_peek(4).sval, val_peek(2).obj, val_peek(0).obj);}
break;
case 56:
//#line 86 "Parser.y"
{yyval.obj = "CallReturn_Stmt"; }
break;
case 57:
//#line 89 "Parser.y"
{yyval.obj = CallArgs(val_peek(0).obj);}
break;
case 58:
//#line 89 "Parser.y"
{yyval.obj = CallArgsEps();}
break;
//#line 776 "Parser.java"
//########## END OF USER-SUPPLIED ACTIONS ##########
    }//switch
    //#### Now let's reduce... ####
    if (yydebug) debug("reduce");
    state_drop(yym);             //we just reduced yylen states
    yystate = state_peek(0);     //get new state
    val_drop(yym);               //corresponding value drop
    yym = yylhs[yyn];            //select next TERMINAL(on lhs)
    if (yystate == 0 && yym == 0)//done? 'rest' state and at first TERMINAL
      {
      if (yydebug) debug("After reduction, shifting from state 0 to state "+YYFINAL+"");
      yystate = YYFINAL;         //explicitly say we're done
      state_push(YYFINAL);       //and save it
      val_push(yyval);           //also save the semantic value of parsing
      if (yychar < 0)            //we want another character?
        {
        yychar = yylex();        //get next character
        if (yychar<0) yychar=0;  //clean, if necessary
        if (yydebug)
          yylexdebug(yystate,yychar);
        }
      if (yychar == 0)          //Good exit (if lex returns 0 ;-)
         break;                 //quit the loop--all DONE
      }//if yystate
    else                        //else not done yet
      {                         //get next state and push, for next yydefred[]
      yyn = yygindex[yym];      //find out where to go
      if ((yyn != 0) && (yyn += yystate) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yystate)
        yystate = yytable[yyn]; //get new state
      else
        yystate = yydgoto[yym]; //else go to new defred
      if (yydebug) debug("after reduction, shifting from state "+state_peek(0)+" to state "+yystate+"");
      state_push(yystate);     //going again, so push state & val...
      val_push(yyval);         //for next action
      }
    }//main loop
  return 0;//yyaccept!!
}
//## end of method parse() ######################################



//## run() --- for Thread #######################################
//## The -Jnorun option was used ##
//## end of method run() ########################################



//## Constructors ###############################################
/**
 * Default constructor.  Turn off with -Jnoconstruct .

 */
public Parser()
{
  //nothing to do
}


/**
 * Create a parser, setting the debug to true or false.
 * @param debugMe true for debugging, false for no debug.
 */
public Parser(boolean debugMe)
{
  yydebug=debugMe;
}
//###############################################################



}
//################### END OF CLASS ##############################
