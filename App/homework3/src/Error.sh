jflex Lexer.flex
yacc.linux -Jthrows="Exception" -Jextends=ParserBase -Jnorun -J Parser.y
echo -e "\nYacc File Compiled Successfully\n"
javac *.java
echo -e "\nJava Files Compiled Successfully\n"
for i in ../testcase/error/*foo; do echo $i; java SemanticChecker $i; echo -e "\n"; done