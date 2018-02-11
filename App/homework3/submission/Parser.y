%{
import java.io.*;
%}

%left OR
%left AND
%right NOT
%left EE NE less great greatE lessE
%left PLUS MINUS
%left MUL DIVIDE PERCENT

%token <sval> NUM ID REAL
%token MAIN PRINT BEGIN END ASSIGN
%token LPAREN RPAREN PLUS MUL SEMI INT
%token COMMA TRUTH FALSEHOOD ELSE IF FLOAT BOOL RETURN WHILE

%type <obj> program type_spec main_decl
%type <obj> local_decls local_decl
%type <obj> stmt_list stmt print_stmt compound_stmt expr_stmt if_stmt while_stmt return_stmt param_list param arg_list args fun_decl expr_stmt
%type <sval> expr 
%type <obj> decl_list decl params 
%%

program       : decl_list main_decl  { $$ = CallProgram($1, $2);    };

decl_list     : decl_list decl 	 { $$ = calldecllist($1, $2);   } | { $$ = 
calldecllisteps(); };
params        : param_list {$$ = CallParam($1);} | {$$ = CallParamsEps();};


fun_decl       : type_spec ID LPAREN params RPAREN SEMI {$$ = CallFun($1, $2, $4);};

decl 	      : fun_decl {$$ = calldec($1);};

main_decl     : MAIN LPAREN RPAREN compound_stmt { $$ = CallMain($4);};


param_list    : param_list COMMA param {$$=CallParamList($1, $3);}| param {$$=CallParam1($1);};

param          : type_spec {$$ = CallParam($1);};

stmt_list     : stmt_list stmt { $$ = CallStmtListRec($1, $2);}   |  { $$ = CallStmtListEps();};

stmt          : compound_stmt { $$ = CallStmtCompound($1); } | print_stmt { $$ = CallStmtPrint($1);} | expr_stmt {$$ = CallExprStmt($1);}| if_stmt {$$ = CallIfStmt($1);}| while_stmt {$$ = CallWhileSt($1);}| return_stmt {$$ = CallReturnStmt($1);};

compound_stmt : BEGIN { $$ = CallCompoundStmtBegin(); } local_decls stmt_list END  { $$ = CallCompoundStmtRest($2, $3, $4); } /* $2 represents result from (1), $3 represents local_decls, and $4 represents stmt_list */;

local_decls   : local_decls local_decl   { $$ = CallLocalDeclsRec($1, $2); } |  { $$ = CallLocalDeclsEps(); };

local_decl    : type_spec ID SEMI   { $$ = CallLocalDecl($1, $2);};

type_spec     : INT { $$ = CallTypeInt();} | FLOAT {$$ = CallTypeFloat();} | BOOL {$$ = CallTypeBool();};

print_stmt    : PRINT expr SEMI  { $$ = CallPrintExpr($2);};

arg_list       : arg_list COMMA expr { $$ = CallArgList($1, $3);} | expr {$$ = CallArgList2($1);};

expr_stmt     : ID ASSIGN expr SEMI { $$ = CallExprStmtIdAssignExpr($1, $3); } | SEMI {};

expr          : expr PLUS expr{ $$ = CallExprAdd($1, $3);} | 
                expr MUL expr { $$ = CallExprMul($1, $3);} | 
                LPAREN expr RPAREN{ $$ = CallExprParen($2);} |
                NUM { $$ = CallFactorNum();} | 
                expr OR expr {$$ = CallORExpr($1, $3);} | 
                expr AND expr {$$ = CallANDExpr($1, $3);} |
                NOT expr {$$ = CallNOTEx($2);} |
                expr great expr {$$ = CallGreat($1, $3);}|
                expr greatE expr {$$ = CallGreatEqual($1, $3);} |
                expr less expr {$$ = CallLess($1, $3);} |
                expr lessE expr{$$ = CallLessEqual($1, $3);} |
                expr MINUS expr{$$ = CallMinus($1, $3);} |
                expr PERCENT expr{$$ = CallPercent($1, $3);} |
                expr DIVIDE expr{$$ = CallDivide($1, $3);} |
                expr EE expr {$$ = CallEqual($1, $3);} |
                expr NE expr {$$ = CallNotEqual($1, $3);} |
                ID { $$ = CallExprId($1);} | 
                TRUTH { $$ = CallExprTrue();} |
                FALSEHOOD { $$= CallExprFalse();} |
                ID LPAREN args RPAREN {$$ = Callexprargs($1, $3);} |
                REAL {$$ = "float";};

while_stmt     : WHILE LPAREN expr RPAREN stmt {$$ = CallWhileStmt($3, $5);};

if_stmt        : IF LPAREN expr RPAREN stmt ELSE stmt { $$ = CallIfEstmt($3, $5, $7);};

return_stmt    : RETURN SEMI    {$$ = "CallReturn_Stmt"; }; //da faq a i do here


args           : arg_list {$$ = CallArgs($1);} | {$$ = CallArgsEps();};

%%
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
