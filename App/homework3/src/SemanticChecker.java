public class SemanticChecker {
	public static void main(String[] args) throws Exception
    {
        //java.io.Reader r = new java.io.StringReader
        //("main()\n"                   // line 1
        //+"{\n"                        // line 2
        //+"    int x;\n"               // line 3
        //+"    print (2+3)*4+5;\n"     // line 4 => print 25
        //+"    print (1+2)*3;\n"       // line 5 => print  9
        //+"    print 1+2*3+4;\n"       // line 6 => print 11
        //+"    print 1+2*(3*4+5);\n"   // line 7 => print 35
        //+"}"                          // line 8
        //);
        if(args.length <= 0)
            return;
        String foopath = args[0];
        java.io.Reader r = new java.io.FileReader(foopath);

        Parser yyparser = new Parser(r);
        try {
            if (yyparser.yyparse() == 0)
                System.out.println("Success");
        }
        catch(Exception e)
        {
        }
	}
}
